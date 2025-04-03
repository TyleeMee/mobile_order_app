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
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_sequence_repository.g.dart';

class CategorySequenceRepository {
  const CategorySequenceRepository(this._firestore, this._ref);
  final FirebaseFirestore _firestore;
  final Ref _ref;

  static String ownerPath(String ownerId) => 'owners/$ownerId';
  static String categorySequencePath(String ownerId) =>
      '${ownerPath(ownerId)}/sortSequences/categorySequence';

  //-----プライベート関数-----

  String _getCurrentOwnerId() {
    // appConfigNotifierからownerIdを取得
    final appConfig = _ref.read(appConfigNotifierProvider);
    return appConfig.ownerId;
  }

  DocumentReference<List<String>> _categorySequenceRef() {
    final ownerId = _getCurrentOwnerId();
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

  // 全カテゴリの取得
  Future<List<String>> fetchCategorySequence() async {
    final doc = await _categorySequenceRef().get();
    return doc.data() ?? [];
  }
}

//+++++Provider+++++

@Riverpod(keepAlive: true)
CategorySequenceRepository categorySequenceRepository(Ref ref) {
  return CategorySequenceRepository(FirebaseFirestore.instance, ref);
}

@riverpod
Future<List<String>> categorySequenceFuture(Ref ref) {
  final categorySequenceRepository = ref.watch(
    categorySequenceRepositoryProvider,
  );
  return categorySequenceRepository.fetchCategorySequence();
}
