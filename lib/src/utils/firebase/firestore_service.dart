import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/utils/firebase/repository_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_service.g.dart';

/// Firestoreサービスの設定オプション
class FirestoreServiceOptions {
  final int maxRetries;
  final Duration baseRetryDelay;
  final bool enableCacheFallback;
  final Duration? cacheTtl;

  const FirestoreServiceOptions({
    this.maxRetries = 3,
    this.baseRetryDelay = const Duration(milliseconds: 300),
    this.enableCacheFallback = true,
    this.cacheTtl,
  });
}

/// Firestoreの操作を抽象化し、再試行ロジックとキャッシュ機能を提供するサービス
class FirestoreService {
  final FirebaseFirestore _firestore;
  final FirestoreServiceOptions options;

  FirestoreService(
    this._firestore, {
    this.options = const FirestoreServiceOptions(),
  });

  /// 単一ドキュメントを取得
  Future<T?> getDocument<T>({
    required DocumentReference<T> docRef,
    bool useCacheFallback = true,
  }) async {
    try {
      // 再試行ロジックを使用してドキュメントを取得
      return await _retryOperation(() async {
        final doc = await docRef.get();
        return doc.exists ? doc.data() : null;
      });
    } catch (e) {
      // キャッシュフォールバックが有効な場合
      if (useCacheFallback && options.enableCacheFallback) {
        if (kDebugMode) {
          print('ネットワークからの取得失敗。キャッシュを試行: $e');
        }

        try {
          final cachedDoc = await docRef.get(
            const GetOptions(source: Source.cache),
          );
          if (cachedDoc.exists) {
            if (kDebugMode) {
              print('キャッシュからドキュメントを取得しました');
            }
            return cachedDoc.data();
          }
        } catch (cacheError) {
          if (kDebugMode) {
            print('キャッシュからの取得も失敗: $cacheError');
          }
        }
      }

      // 元のエラーを再スロー
      if (e is FirebaseException) {
        throw RepositoryException.fromFirebaseException(e);
      }
      throw RepositoryException('ドキュメント取得に失敗しました', originalError: e);
    }
  }

  /// クエリを実行してコレクションのデータを取得
  Future<List<T>> getCollection<T>({
    required Query<T> query,
    bool useCacheFallback = true,
  }) async {
    try {
      return await _retryOperation(() async {
        final snapshot = await query.get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      // キャッシュフォールバックが有効な場合
      if (useCacheFallback && options.enableCacheFallback) {
        if (kDebugMode) {
          print('ネットワークからのコレクション取得失敗。キャッシュを試行: $e');
        }

        try {
          final cachedSnapshot = await query.get(
            const GetOptions(source: Source.cache),
          );
          if (cachedSnapshot.docs.isNotEmpty) {
            if (kDebugMode) {
              print('キャッシュからコレクションを取得しました: ${cachedSnapshot.docs.length}件');
            }
            return cachedSnapshot.docs.map((doc) => doc.data()).toList();
          }
        } catch (cacheError) {
          if (kDebugMode) {
            print('キャッシュからのコレクション取得も失敗: $cacheError');
          }
        }
      }

      // 元のエラーを再スロー
      if (e is FirebaseException) {
        throw RepositoryException.fromFirebaseException(e);
      }
      throw RepositoryException('コレクション取得に失敗しました', originalError: e);
    }
  }

  /// ドキュメントを追加（ドキュメントIDを自動発行）
  Future<DocumentReference<T>> addDocument<T>({
    required CollectionReference<T> colRef,
    required T data,
  }) async {
    try {
      return await _retryOperation(() => colRef.add(data));
    } catch (e) {
      if (e is FirebaseException) {
        throw RepositoryException.fromFirebaseException(e);
      }
      throw RepositoryException('ドキュメント追加に失敗しました', originalError: e);
    }
  }

  /// ドキュメントを部分的に更新する
  Future<void> updateDocument<T>({
    required DocumentReference<T> docRef,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _retryOperation(() => docRef.update(data));
    } catch (e) {
      if (e is FirebaseException) {
        throw RepositoryException.fromFirebaseException(e);
      }
      throw RepositoryException('ドキュメント更新に失敗しました', originalError: e);
    }
  }

  /// ドキュメントを追加または更新
  Future<void> setDocument<T>({
    required DocumentReference<T> docRef,
    required T data,
    bool merge = true,
  }) async {
    try {
      await _retryOperation(() => docRef.set(data, SetOptions(merge: merge)));
    } catch (e) {
      if (e is FirebaseException) {
        throw RepositoryException.fromFirebaseException(e);
      }
      throw RepositoryException('ドキュメント保存に失敗しました', originalError: e);
    }
  }

  /// ドキュメントを削除
  Future<void> deleteDocument({required DocumentReference docRef}) async {
    try {
      await _retryOperation(() => docRef.delete());
    } catch (e) {
      if (e is FirebaseException) {
        throw RepositoryException.fromFirebaseException(e);
      }
      throw RepositoryException('ドキュメント削除に失敗しました', originalError: e);
    }
  }

  /// トランザクションを実行
  Future<T> runTransaction<T>({
    required Future<T> Function(Transaction) transactionFn,
    int maxAttempts = 5,
  }) async {
    try {
      return await _retryOperation(
        () =>
            _firestore.runTransaction(transactionFn, maxAttempts: maxAttempts),
      );
    } catch (e) {
      if (e is FirebaseException) {
        throw RepositoryException.fromFirebaseException(e);
      }
      throw RepositoryException('トランザクション実行に失敗しました', originalError: e);
    }
  }

  /// バッチ書き込みを実行
  Future<void> runBatch({required void Function(WriteBatch) batchFn}) async {
    try {
      await _retryOperation(() async {
        final batch = _firestore.batch();
        batchFn(batch);
        return batch.commit();
      });
    } catch (e) {
      if (e is FirebaseException) {
        throw RepositoryException.fromFirebaseException(e);
      }
      throw RepositoryException('バッチ処理実行に失敗しました', originalError: e);
    }
  }

  //* ネットワークやバックエンドサービスの一時中断時にすぐにエラー画面に遷移しないようにするため
  /// 再試行ロジックを実装した内部ヘルパーメソッド
  Future<T> _retryOperation<T>(Future<T> Function() operation) async {
    int attempt = 0;

    while (true) {
      try {
        return await operation();
      } catch (e) {
        attempt++;

        // 最大再試行回数に達した場合はエラーを再スロー
        if (attempt >= options.maxRetries) {
          rethrow;
        }

        // 待機時間を計算（指数バックオフ）
        final waitTime = Duration(
          milliseconds: options.baseRetryDelay.inMilliseconds * attempt,
        );

        if (kDebugMode) {
          print(
            '操作に失敗しました。再試行 $attempt/${options.maxRetries - 1} を ${waitTime.inMilliseconds}ms後に実行します',
          );
        }

        await Future.delayed(waitTime);
      }
    }
  }
}

@Riverpod(keepAlive: true)
FirestoreService firestoreService(Ref ref) {
  return FirestoreService(FirebaseFirestore.instance);
}

@riverpod
FirestoreService customFirestoreService(
  Ref ref,
  FirestoreServiceOptions options,
) {
  return FirestoreService(FirebaseFirestore.instance, options: options);
}
