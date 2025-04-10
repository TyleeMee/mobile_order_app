import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/features/categories/domain/category.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:mobile_order_app/src/utils/firebase/firestore_converters.dart';
import 'package:mobile_order_app/src/utils/firebase/firestore_service.dart';
import 'package:mobile_order_app/src/utils/firebase/repository_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_repository.g.dart';

class CategoriesRepository {
  const CategoriesRepository(
    this._firestore,
    this._firestoreService,
    this._ref,
  );
  final FirebaseFirestore _firestore;
  final FirestoreService _firestoreService;
  final Ref _ref;

  static String ownerPath(String ownerId) => 'owners/$ownerId';
  static String categoriesPath(String ownerId) =>
      '${ownerPath(ownerId)}/categories';
  static String categoryPath(String ownerId, CategoryID id) =>
      '${categoriesPath(ownerId)}/$id';

  //-----プライベート関数-----

  // 有効なownerIdを取得
  Future<String> _getValidOwnerId() async {
    return _ref.read(validOwnerIdProvider.future);
  }

  Future<DocumentReference<Category>> _getCategoryRef(CategoryID id) async {
    final ownerId = await _getValidOwnerId();
    return _firestore
        .doc(categoryPath(ownerId, id))
        .withConverter(
          fromFirestore:
              (doc, _) => FirestoreConverters.toCategory(doc.id, doc.data()!),
          toFirestore: (Category category, options) => category.toMap(),
        );
  }

  Future<CollectionReference<Category>> _getCategoriesRef() async {
    final ownerId = await _getValidOwnerId();
    return _firestore
        .collection(categoriesPath(ownerId))
        .withConverter(
          fromFirestore:
              (doc, _) => FirestoreConverters.toCategory(doc.id, doc.data()!),
          toFirestore: (Category category, options) => category.toMap(),
        );
  }

  //=====取得メソッド=====

  // 全カテゴリの取得（キャッシュフォールバック付き）
  Future<List<Category>> fetchCategories() async {
    try {
      final categoriesRef = await _getCategoriesRef();
      return await _firestoreService.getCollection(
        query: categoriesRef,
        useCacheFallback: true,
      );
    } catch (e) {
      throw RepositoryException('カテゴリリストの取得に失敗しました', originalError: e);
    }
  }

  // 特定のカテゴリを取得（キャッシュフォールバック付き）
  Future<Category?> fetchCategory(CategoryID id) async {
    try {
      final categoryRef = await _getCategoryRef(id);
      return await _firestoreService.getDocument(
        docRef: categoryRef,
        useCacheFallback: true,
      );
    } catch (e) {
      throw RepositoryException('カテゴリの取得に失敗しました', originalError: e);
    }
  }
}

//+++++Provider+++++

@Riverpod(keepAlive: true)
CategoriesRepository categoriesRepository(Ref ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return CategoriesRepository(
    FirebaseFirestore.instance,
    firestoreService,
    ref,
  );
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
