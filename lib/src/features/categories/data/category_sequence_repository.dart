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
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:mobile_order_app/src/utils/firebase/data_converters.dart';
import 'package:mobile_order_app/src/utils/firebase/firestore_service.dart';
import 'package:mobile_order_app/src/utils/firebase/repository_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_sequence_repository.g.dart';

class CategorySequenceRepository {
  const CategorySequenceRepository(
    this._firestore,
    this._firestoreService,
    this._ref,
  );
  final FirebaseFirestore _firestore;
  final FirestoreService _firestoreService;
  final Ref _ref;

  static String ownerPath(String ownerId) => 'owners/$ownerId';
  static String categorySequencePath(String ownerId) =>
      '${ownerPath(ownerId)}/sortSequences/categorySequence';

  //-----プライベート関数-----

  Future<String> _getValidOwnerId() {
    return _ref.read(validOwnerIdProvider.future);
  }

  Future<DocumentReference<List<String>>> _categorySequenceRef() async {
    final ownerId = await _getValidOwnerId();
    return _firestore
        .doc(categorySequencePath(ownerId))
        .withConverter(
          fromFirestore:
              (doc, _) => FirestoreConverters.toStringList(doc.data(), 'ids'),
          toFirestore:
              (List<String> categorySequence, options) => {
                'ids': categorySequence,
              },
        );
  }

  //=====取得メソッド=====

  // 全カテゴリの取得（キャッシュフォールバック付き）
  Future<List<String>> fetchCategorySequence() async {
    try {
      final categorySequenceRef = await _categorySequenceRef();
      final result = await _firestoreService.getDocument(
        docRef: categorySequenceRef,
        useCacheFallback: true,
      );
      return result ?? [];
    } catch (e) {
      throw RepositoryException('カテゴリのシーケンス取得に失敗しました', originalError: e);
    }
  }
}

//+++++Provider+++++

@Riverpod(keepAlive: true)
CategorySequenceRepository categorySequenceRepository(Ref ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return CategorySequenceRepository(
    FirebaseFirestore.instance,
    firestoreService,
    ref,
  );
}

@riverpod
Future<List<String>> categorySequenceFuture(Ref ref) {
  final categorySequenceRepository = ref.watch(
    categorySequenceRepositoryProvider,
  );
  return categorySequenceRepository.fetchCategorySequence();
}
