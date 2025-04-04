//=====データ構造=====

// sortSequences（コレクション）
//   - categorySequence（ドキュメント）
//     - ids: string[]  // カテゴリーIDの配列（順序付き）

//   - productSequencesByCategoryId（ドキュメント）
//     - categoryId_1: string[]  // カテゴリー1内のproductIDの配列（順序付き）
//     - categoryId_2: string[]  // カテゴリー2内のproductIDの配列（順序付き）
//     - ...他のカテゴリー

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/features/categories/domain/category.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:mobile_order_app/src/utils/firebase/data_converters.dart';
import 'package:mobile_order_app/src/utils/firebase/firestore_service.dart';
import 'package:mobile_order_app/src/utils/firebase/repository_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_sequences_repository.g.dart';

class ProductSequencesRepository {
  const ProductSequencesRepository(
    this._firestore,
    this._firestoreService,
    this._ref,
  );
  final FirebaseFirestore _firestore;
  final FirestoreService _firestoreService;
  final Ref _ref;

  static String ownerPath(String ownerId) => 'owners/$ownerId';
  static String productSequencesByCategoryIdPath(String ownerId) =>
      '${ownerPath(ownerId)}/sortSequences/productSequencesByCategoryId';

  //-----プライベート関数-----

  Future<String> _getValidOwnerId() {
    return _ref.read(validOwnerIdProvider.future);
  }

  Future<DocumentReference<List<String>>> _productSequenceInCategoryRef(
    CategoryID categoryId,
  ) async {
    final ownerId = await _getValidOwnerId();
    return _firestore
        .doc(productSequencesByCategoryIdPath(ownerId))
        .withConverter(
          fromFirestore:
              (doc, _) =>
                  FirestoreConverters.toStringList(doc.data(), categoryId),
          toFirestore:
              (List<String> categorySequence, options) => {
                categoryId: categorySequence,
              },
        );
  }

  //=====取得メソッド=====

  // 全カテゴリの取得（キャッシュフォールバック付き）
  Future<List<String>> fetchProductSequenceInCategory(
    CategoryID categoryId,
  ) async {
    try {
      final productSequenceInCategoryRef = await _productSequenceInCategoryRef(
        categoryId,
      );
      final result = await _firestoreService.getDocument(
        docRef: productSequenceInCategoryRef,
        useCacheFallback: true,
      );
      return result ?? [];
    } catch (e) {
      throw RepositoryException('カテゴリ内の商品シーケンス取得に失敗しました', originalError: e);
    }
  }
}

//+++++Provider+++++

@Riverpod(keepAlive: true)
ProductSequencesRepository productSequencesRepository(Ref ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return ProductSequencesRepository(
    FirebaseFirestore.instance,
    firestoreService,
    ref,
  );
}

@riverpod
Future<List<String>> productSequenceInCategory(Ref ref, CategoryID categoryId) {
  final productSequencesRepository = ref.watch(
    productSequencesRepositoryProvider,
  );
  return productSequencesRepository.fetchProductSequenceInCategory(categoryId);
}
