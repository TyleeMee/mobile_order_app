import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/features/shop/domain/shop.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:mobile_order_app/src/utils/firebase/firestore_converters.dart';
import 'package:mobile_order_app/src/utils/firebase/firestore_service.dart';
import 'package:mobile_order_app/src/utils/firebase/repository_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shop_repository.g.dart';

class ShopRepository {
  ShopRepository(this._firestore, this._firestoreService, this._ref);
  final FirebaseFirestore _firestore;
  final FirestoreService _firestoreService;
  final Ref _ref;

  // コレクションパス関連のヘルパーメソッド
  String _ownerPath(String ownerId) => 'owners/$ownerId';
  String _shopPath(String ownerId) => '${_ownerPath(ownerId)}/shop/shop';

  // 現在のオーナーIDを取得
  Future<String> _getValidOwnerId() {
    return _ref.read(validOwnerIdProvider.future);
  }

  // 店舗ドキュメント参照を取得
  Future<DocumentReference<Shop>> _shopRef() async {
    final ownerId = await _getValidOwnerId();
    return _firestore
        .doc(_shopPath(ownerId))
        .withConverter(
          fromFirestore:
              (doc, _) => FirestoreConverters.toShop(doc.id, doc.data()!),
          toFirestore: (Shop shop, options) => shop.toMap(),
        );
  }

  //=====取得メソッド=====
  /// 店舗を取得（キャッシュフォールバック付き）
  Future<Shop?> fetchShop() async {
    try {
      final shopRef = await _shopRef();
      return await _firestoreService.getDocument(
        docRef: shopRef,
        useCacheFallback: true,
      );
    } catch (e) {
      throw RepositoryException('店舗の取得に失敗しました', originalError: e);
    }
  }
}

//+++++Provider+++++

@Riverpod(keepAlive: true)
ShopRepository shopRepository(Ref ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return ShopRepository(FirebaseFirestore.instance, firestoreService, ref);
}

/// 店舗を取得するProvider
@riverpod
Future<Shop?> shop(Ref ref) {
  final shopRepository = ref.watch(shopRepositoryProvider);
  return shopRepository.fetchShop();
}
