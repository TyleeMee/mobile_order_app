//TODO 元々ProductsRepositoryをこれで置き換えるためにProductsServiceを作成したが、不要なら消す。
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/features/categories/domain/category.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:mobile_order_app/src/utils/firebase/firestore_service.dart';
import 'package:mobile_order_app/src/utils/firebase/repository_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_service.g.dart';

/// 商品関連の操作を提供するサービスクラス
class ProductsService {
  ProductsService(this._firestore, this._firestoreService, this._ref);
  final FirebaseFirestore _firestore;
  final FirestoreService _firestoreService;
  final Ref _ref;

  // コレクションパス関連のヘルパーメソッド
  String _ownerPath(String ownerId) => 'owners/$ownerId';
  String _productsPath(String ownerId) => '${_ownerPath(ownerId)}/products';
  String _productPath(String ownerId, ProductID id) =>
      '${_productsPath(ownerId)}/$id';

  // 現在のオーナーIDを取得
  String _getCurrentOwnerId() {
    final appConfig = _ref.read(appConfigNotifierProvider);
    return appConfig.ownerId;
  }

  // 商品ドキュメント参照を取得
  DocumentReference<Product> _productRef(ProductID id) {
    final ownerId = _getCurrentOwnerId();
    return _firestore
        .doc(_productPath(ownerId, id))
        .withConverter(
          fromFirestore: (doc, _) => Product.fromMap(doc.id, doc.data()!),
          toFirestore: (Product product, options) => product.toMap(),
        );
  }

  // 商品コレクション参照を取得
  CollectionReference<Product> _productsRef() {
    final ownerId = _getCurrentOwnerId();
    return _firestore
        .collection(_productsPath(ownerId))
        .withConverter(
          fromFirestore: (doc, _) => Product.fromMap(doc.id, doc.data()!),
          toFirestore: (Product product, options) => product.toMap(),
        );
  }

  /// カテゴリ内の商品を取得（公開ステータスのものだけ）
  Future<List<Product>> fetchProductsInCategory(CategoryID categoryId) async {
    try {
      final query = _productsRef()
          .where("categoryId", isEqualTo: categoryId)
          .where("isVisible", isEqualTo: true);

      return await _firestoreService.getCollection(query: query);
    } catch (e) {
      throw RepositoryException('カテゴリ内の商品取得に失敗しました', originalError: e);
    }
  }

  /// 特定の商品を取得（キャッシュフォールバック付き）
  Future<Product?> getProduct(ProductID id) async {
    try {
      return await _firestoreService.getDocument(
        docRef: _productRef(id),
        useCacheFallback: true,
      );
    } catch (e) {
      throw RepositoryException('商品の取得に失敗しました', originalError: e);
    }
  }

  /// 商品詳細をキャッシュから取得（オフライン用）
  Future<Product?> getProductFromCache(ProductID id) async {
    try {
      return await _firestoreService.getDocument(
        docRef: _productRef(id),
        useCacheFallback: false, // 既にキャッシュアクセスなので不要
      );
    } catch (e) {
      // キャッシュ取得の失敗は静かに処理
      return null;
    }
  }

  /// 特定のキーワードで商品を検索
  Future<List<Product>> searchProducts(String keyword) async {
    try {
      // 注: Firestoreの基本機能ではテキスト検索が限られているため、
      // 実際の実装ではAlgoliaなどの検索サービスを検討することをお勧めします
      final query = _productsRef()
          .where("isVisible", isEqualTo: true)
          .orderBy("title");

      final products = await _firestoreService.getCollection(query: query);

      // クライアント側でキーワードフィルタリング
      if (keyword.isEmpty) {
        return products;
      }

      final lowercaseKeyword = keyword.toLowerCase();
      return products.where((product) {
        return product.title.toLowerCase().contains(lowercaseKeyword) ||
            (product.description?.toLowerCase().contains(lowercaseKeyword) ??
                false);
      }).toList();
    } catch (e) {
      throw RepositoryException('商品の検索に失敗しました', originalError: e);
    }
  }

  /// おすすめ商品を取得
  Future<List<Product>> getFeaturedProducts({int limit = 10}) async {
    try {
      final query = _productsRef()
          .where("isVisible", isEqualTo: true)
          .where("isFeatured", isEqualTo: true)
          .limit(limit);

      return await _firestoreService.getCollection(query: query);
    } catch (e) {
      throw RepositoryException('おすすめ商品の取得に失敗しました', originalError: e);
    }
  }
}

//+++++Provider+++++

@Riverpod(keepAlive: true)
ProductsService productsService(Ref ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return ProductsService(FirebaseFirestore.instance, firestoreService, ref);
}

/// カテゴリ内の商品を取得するProvider
@riverpod
Future<List<Product>> productsInCategory(Ref ref, CategoryID categoryId) {
  final service = ref.watch(productsServiceProvider);
  return service.fetchProductsInCategory(categoryId);
}

/// 特定の商品を取得するProvider（改良版）
@riverpod
Future<Product?> product(Ref ref, ProductID id) async {
  final service = ref.watch(productsServiceProvider);

  try {
    // メインのリクエスト
    return await service.getProduct(id);
  } catch (e) {
    // エラーが発生した場合、自動的にキャッシュから取得を試みる
    final cachedProduct = await service.getProductFromCache(id);
    if (cachedProduct != null) {
      return cachedProduct;
    }

    // キャッシュからも取得できなかった場合は元のエラーを再スロー
    rethrow;
  }
}

/// おすすめ商品を取得するProvider
@riverpod
Future<List<Product>> featuredProducts(Ref ref, {int limit = 10}) {
  final service = ref.watch(productsServiceProvider);
  return service.getFeaturedProducts(limit: limit);
}

/// 商品検索Provider
@riverpod
Future<List<Product>> searchProducts(Ref ref, String keyword) {
  final service = ref.watch(productsServiceProvider);
  return service.searchProducts(keyword);
}
