import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// リポジトリ操作の例外を表すクラス
class RepositoryException implements Exception {
  final String message;
  final Object? originalError;
  final String? code;

  RepositoryException(this.message, {this.originalError, this.code});

  @override
  String toString() =>
      'RepositoryException: $message${code != null ? ' (code: $code)' : ''}';

  /// Firebaseエラーからリポジトリ例外を作成するファクトリメソッド
  factory RepositoryException.fromFirebaseException(FirebaseException e) {
    String message;
    String? code = e.code;

    switch (e.code) {
      case 'unavailable':
        message = 'サービスが利用できません。インターネット接続を確認してください。';
        break;
      case 'network-request-failed':
        message = 'ネットワーク接続に問題があります。';
        break;
      case 'permission-denied':
        message = 'アクセス権限がありません。';
        break;
      case 'not-found':
        message = 'リクエストされたリソースが見つかりません。';
        break;
      default:
        message = 'エラーが発生しました: ${e.message ?? e.code}';
    }

    return RepositoryException(message, originalError: e, code: code);
  }
}

/// リポジトリの基本機能を提供する抽象クラス
abstract class RepositoryBase {
  const RepositoryBase();

  /// 再試行可能な操作を実行するヘルパーメソッド
  Future<T> runWithRetry<T>({
    required Future<T> Function() operation,
    int maxRetries = 3,
    Duration? baseDelay,
  }) async {
    baseDelay ??= const Duration(milliseconds: 300);

    for (int attempt = 0; attempt < maxRetries; attempt++) {
      try {
        return await operation();
      } catch (e) {
        // 最後の試行でエラーが発生した場合は例外をスロー
        if (attempt == maxRetries - 1) {
          if (e is FirebaseException) {
            throw RepositoryException.fromFirebaseException(e);
          }
          if (kDebugMode) {
            print('Repository操作エラー(${attempt + 1}回目): $e');
          }
          throw RepositoryException('操作に失敗しました', originalError: e);
        }

        // 次の再試行の前に待機（指数バックオフ）
        final waitTime = Duration(
          milliseconds: baseDelay.inMilliseconds * (attempt + 1),
        );
        if (kDebugMode) {
          print(
            '再試行待機中(${attempt + 1}/${maxRetries - 1}): ${waitTime.inMilliseconds}ms',
          );
        }
        await Future.delayed(waitTime);
      }
    }

    // コードがここに到達することはないはず
    throw RepositoryException('予期しないエラーが発生しました');
  }
}

/// Firestoreリポジトリの基本機能を提供する抽象クラス
abstract class FirestoreRepository extends RepositoryBase {
  final FirebaseFirestore firestore;

  const FirestoreRepository(this.firestore);

  /// キャッシュからドキュメントを取得するヘルパーメソッド
  Future<T?> getFromCache<T>({required DocumentReference<T> reference}) async {
    try {
      final doc = await reference.get(const GetOptions(source: Source.cache));
      return doc.exists ? doc.data() : null;
    } catch (e) {
      if (kDebugMode) {
        print('キャッシュからの取得に失敗: $e');
      }
      return null; // キャッシュエラーは静かに失敗
    }
  }

  /// キャッシュからコレクションを取得するヘルパーメソッド
  Future<List<T>> getCollectionFromCache<T>({required Query<T> query}) async {
    try {
      final snapshot = await query.get(const GetOptions(source: Source.cache));
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      if (kDebugMode) {
        print('キャッシュからのコレクション取得に失敗: $e');
      }
      return []; // キャッシュエラーは空のリストを返す
    }
  }

  /// メインのネットワークから取得を試み、失敗したらキャッシュから取得するヘルパーメソッド（単一ドキュメント用）
  Future<T?> getWithCacheFallback<T>({
    required DocumentReference<T> reference,
    int maxRetries = 3,
  }) async {
    try {
      // メインのリクエスト（自動再試行付き）
      return await runWithRetry(
        operation:
            () => reference.get().then((doc) => doc.exists ? doc.data() : null),
        maxRetries: maxRetries,
      );
    } catch (e) {
      if (kDebugMode) {
        print('ネットワークからの取得に失敗: $e');
        print('キャッシュからの取得を試みます...');
      }

      // エラーが発生した場合、キャッシュから取得を試みる
      final cachedData = await getFromCache(reference: reference);
      if (cachedData != null) {
        if (kDebugMode) {
          print('キャッシュからデータを取得しました');
        }
        return cachedData;
      }

      // キャッシュからも取得できなかった場合は元のエラーを再スロー
      rethrow;
    }
  }

  /// メインのネットワークから取得を試み、失敗したらキャッシュから取得するヘルパーメソッド（コレクション用）
  Future<List<T>> getCollectionWithCacheFallback<T>({
    required Query<T> query,
    int maxRetries = 3,
  }) async {
    try {
      // メインのリクエスト（自動再試行付き）
      return await runWithRetry(
        operation: () async {
          final snapshot = await query.get();
          return snapshot.docs.map((doc) => doc.data()).toList();
        },
        maxRetries: maxRetries,
      );
    } catch (e) {
      if (kDebugMode) {
        print('ネットワークからのコレクション取得に失敗: $e');
        print('キャッシュからのコレクション取得を試みます...');
      }

      // エラーが発生した場合、キャッシュから取得を試みる
      final cachedData = await getCollectionFromCache(query: query);
      if (cachedData.isNotEmpty) {
        if (kDebugMode) {
          print('キャッシュからコレクションデータを取得しました: ${cachedData.length}件');
        }
        return cachedData;
      }

      // キャッシュからも取得できなかった場合は元のエラーを再スロー
      rethrow;
    }
  }

  /// クエリ実行を再試行ロジック付きで行うヘルパーメソッド
  Future<List<T>> queryWithRetry<T>({
    required Query<T> query,
    int maxRetries = 3,
  }) async {
    return runWithRetry(
      operation: () async {
        final snapshot = await query.get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      },
      maxRetries: maxRetries,
    );
  }
}
