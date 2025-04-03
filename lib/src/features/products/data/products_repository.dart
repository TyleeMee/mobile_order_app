import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/features/categories/domain/category.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_repository.g.dart';

class ProductsRepository {
  const ProductsRepository(this._firestore, this._ref);
  final FirebaseFirestore _firestore;
  final Ref _ref;

  static String ownerPath(String ownerId) => 'owners/$ownerId';
  static String productsPath(String ownerId) =>
      '${ownerPath(ownerId)}/products';
  static String productPath(String ownerId, ProductID id) =>
      '${productsPath(ownerId)}/$id';

  //-----プライベート関数-----

  String _getCurrentOwnerId() {
    // appConfigNotifierからownerIdを取得
    final appConfig = _ref.read(appConfigNotifierProvider);
    return appConfig.ownerId;
  }

  DocumentReference<Product> _productRef(ProductID id) {
    final ownerId = _getCurrentOwnerId();
    return _firestore
        .doc(productPath(ownerId, id))
        .withConverter(
          fromFirestore: (doc, _) => Product.fromMap(doc.id, doc.data()!),
          toFirestore: (Product product, options) => product.toMap(),
        );
  }

  CollectionReference<Product> _productsRef() {
    final ownerId = _getCurrentOwnerId();
    return _firestore
        .collection(productsPath(ownerId))
        .withConverter(
          fromFirestore: (doc, _) => Product.fromMap(doc.id, doc.data()!),
          toFirestore: (Product product, options) => product.toMap(),
        );
  }

  //=====取得メソッド=====

  // カテゴリ内の商品取得（公開ステータスのものだけ）
  Future<List<Product>> fetchProductsInCategory(CategoryID id) async {
    final snapshot =
        await _productsRef()
            .where("categoryId", isEqualTo: id)
            .where("isVisible", isEqualTo: true)
            .get();

    if (snapshot.docs.isEmpty) {
      return [];
    }

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Stream<List<Product>> watchProductsInCategory(CategoryID id) {
    final ref = _productsRef()
        .where("categoryId", isEqualTo: id)
        .where("isVisible", isEqualTo: true);

    return ref.snapshots().map(
      (snapshot) =>
          snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList(),
    );
  }

  // 特定の商品を取得
  Future<Product?> fetchProduct(ProductID id) async {
    final doc = await _productRef(id).get();
    return doc.data();
  }

  Stream<Product?> watchProduct(ProductID id) {
    final ref = _productRef(id);
    return ref.snapshots().map((snapshot) => snapshot.data());
  }
}

//+++++Provider+++++

@Riverpod(keepAlive: true)
ProductsRepository productsRepository(Ref ref) {
  return ProductsRepository(FirebaseFirestore.instance, ref);
}

@riverpod
Future<List<Product>> productsInCategoryFuture(Ref ref, CategoryID id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductsInCategory(id);
}

@riverpod
Stream<List<Product>> productsInCategoryStream(Ref ref, CategoryID id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductsInCategory(id);
}

@riverpod
Future<Product?> productFuture(Ref ref, ProductID id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProduct(id);
}

@riverpod
Stream<Product?> productStream(Ref ref, ProductID id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
}
