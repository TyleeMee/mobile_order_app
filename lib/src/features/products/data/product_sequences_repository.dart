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
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_sequences_repository.g.dart';

class ProductSequencesRepository {
  const ProductSequencesRepository(this._firestore, this._ref);
  final FirebaseFirestore _firestore;
  final Ref _ref;

  static String ownerPath(String ownerId) => 'owners/$ownerId';
  static String productSequencesByCategoryIdPath(String ownerId) =>
      '${ownerPath(ownerId)}/sortSequences/productSequencesByCategoryId';

  //-----プライベート関数-----

  String _getCurrentOwnerId() {
    // appConfigNotifierからownerIdを取得
    final appConfig = _ref.read(appConfigNotifierProvider);
    return appConfig.ownerId;
  }

  DocumentReference<List<String>> _productSequenceInCategoryRef(
    CategoryID categoryId,
  ) {
    final ownerId = _getCurrentOwnerId();
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

  // 全カテゴリの取得
  Future<List<String>> fetchProductSequenceInCategory(
    CategoryID categoryId,
  ) async {
    final doc = await _productSequenceInCategoryRef(categoryId).get();
    return doc.data() ?? [];
  }
}

//+++++Provider+++++

@Riverpod(keepAlive: true)
ProductSequencesRepository productSequencesRepository(Ref ref) {
  return ProductSequencesRepository(FirebaseFirestore.instance, ref);
}

@riverpod
Future<List<String>> productSequenceInCategoryFuture(
  Ref ref,
  CategoryID categoryId,
) {
  final productSequencesRepository = ref.watch(
    productSequencesRepositoryProvider,
  );
  return productSequencesRepository.fetchProductSequenceInCategory(categoryId);
}
