import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/features/categories/domain/category.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_repository.g.dart';

class CategoriesRepository {
  const CategoriesRepository(this._firestore, this._ref);
  final FirebaseFirestore _firestore;
  final Ref _ref;

  static String ownerPath(String ownerId) => 'owners/$ownerId';
  static String categoriesPath(String ownerId) =>
      '${ownerPath(ownerId)}/categories';
  static String categoryPath(String ownerId, CategoryID id) =>
      '${categoriesPath(ownerId)}/$id';

  //-----プライベート関数-----

  // 有効なownerIdを待つ関数
  Future<String> _waitForValidOwnerId() async {
    // 現在のownerIdを確認
    final appConfig = _ref.read(appConfigNotifierProvider);

    // すでに有効なownerIdがある場合はそれを返す
    if (appConfig.ownerId.isNotEmpty) {
      debugPrint('有効なownerIdがあります: ${appConfig.ownerId}');
      return appConfig.ownerId;
    }

    // 有効なownerIdが設定されるまで待機
    debugPrint('有効なownerIdを待っています...');

    // 最大3秒間、ポーリングしてownerIdが設定されるのを待つ
    for (int i = 0; i < 30; i++) {
      await Future.delayed(const Duration(milliseconds: 100));

      final updatedConfig = _ref.read(appConfigNotifierProvider);
      if (updatedConfig.ownerId.isNotEmpty) {
        debugPrint('有効なownerIdが設定されました: ${updatedConfig.ownerId}');
        return updatedConfig.ownerId;
      }
    }

    // タイムアウトした場合はエラーをスロー
    throw Exception('ownerIdの初期化タイムアウト: 有効なownerIdが設定されませんでした');
  }

  Future<DocumentReference<Category>> _getCategoryRef(CategoryID id) async {
    final ownerId = await _waitForValidOwnerId();
    return _firestore
        .doc(categoryPath(ownerId, id))
        .withConverter(
          fromFirestore: (doc, _) => Category.fromMap(doc.id, doc.data()!),
          toFirestore: (Category category, options) => category.toMap(),
        );
  }

  Future<CollectionReference<Category>> _getCategoriesRef() async {
    final ownerId = await _waitForValidOwnerId();
    return _firestore
        .collection(categoriesPath(ownerId))
        .withConverter(
          fromFirestore: (doc, _) => Category.fromMap(doc.id, doc.data()!),
          toFirestore: (Category category, options) => category.toMap(),
        );
  }

  //TODO デバッグが終わったら、それぞれの取得メソッドのtrycatchを消す。
  //=====取得メソッド=====

  // 全カテゴリの取得
  Future<List<Category>> fetchCategories() async {
    try {
      final categoriesRef = await _getCategoriesRef();
      final snapshot = await categoriesRef.get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      debugPrint('カテゴリ取得エラー: $e');
      return [];
    }
  }

  // 特定のカテゴリを取得
  Future<Category?> fetchCategory(CategoryID id) async {
    try {
      final categoryRef = await _getCategoryRef(id);
      final doc = await categoryRef.get();
      return doc.data();
    } catch (e) {
      debugPrint('カテゴリ取得エラー: $e');
      return null;
    }
  }
}

//+++++Provider+++++

@Riverpod(keepAlive: true)
CategoriesRepository categoriesRepository(Ref ref) {
  return CategoriesRepository(FirebaseFirestore.instance, ref);
}

@riverpod
Future<List<Category>> categoriesFuture(Ref ref) {
  final categoriesRepository = ref.watch(categoriesRepositoryProvider);
  return categoriesRepository.fetchCategories();
}

@riverpod
Future<Category?> categoryFuture(Ref ref, CategoryID id) {
  final categoriesRepository = ref.watch(categoriesRepositoryProvider);
  return categoriesRepository.fetchCategory(id);
}
