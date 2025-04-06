import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/features/categories/domain/category.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:mobile_order_app/src/utils/firebase/firestore_service.dart';
import 'package:mobile_order_app/src/utils/firebase/repository_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_repository.g.dart';

/// 商品関連の操作を提供するサービスクラス
class ProductsRepository {
  ProductsRepository(this._firestore, this._firestoreService, this._ref);
  final FirebaseFirestore _firestore;
  final FirestoreService _firestoreService;
  final Ref _ref;

  // コレクションパス関連のヘルパーメソッド
  String _ownerPath(String ownerId) => 'owners/$ownerId';
  String _productsPath(String ownerId) => '${_ownerPath(ownerId)}/products';
  String _productPath(String ownerId, ProductID id) =>
      '${_productsPath(ownerId)}/$id';

  // 現在のオーナーIDを取得
  Future<String> _getValidOwnerId() {
    return _ref.read(validOwnerIdProvider.future);
  }

  // 商品ドキュメント参照を取得
  Future<DocumentReference<Product>> _productRef(ProductID id) async {
    final ownerId = await _getValidOwnerId();
    return _firestore
        .doc(_productPath(ownerId, id))
        .withConverter(
          fromFirestore: (doc, _) => Product.fromMap(doc.id, doc.data()!),
          toFirestore: (Product product, options) => product.toMap(),
        );
  }

  // 商品コレクション参照を取得
  Future<CollectionReference<Product>> _productsRef() async {
    final ownerId = await _getValidOwnerId();
    return _firestore
        .collection(_productsPath(ownerId))
        .withConverter(
          fromFirestore: (doc, _) => Product.fromMap(doc.id, doc.data()!),
          toFirestore: (Product product, options) => product.toMap(),
        );
  }

  //=====取得メソッド=====

  /// カテゴリ内の商品を取得（公開ステータスのものだけ,キャッシュフォールバック付き）
  Future<List<Product>> fetchProductsInCategory(CategoryID categoryId) async {
    try {
      final productsRef = await _productsRef();
      final query = productsRef
          .where("categoryId", isEqualTo: categoryId)
          .where("isVisible", isEqualTo: true);

      return await _firestoreService.getCollection(
        query: query,
        useCacheFallback: true,
      );
    } catch (e) {
      throw RepositoryException('カテゴリ内の商品取得に失敗しました', originalError: e);
    }
  }

  ///カート内の全商品を取得（キャッシュフォールバック付き）
  Future<List<Product>> fetchProductsByIds(List<ProductID> productIds) async {
    try {
      if (productIds.isEmpty) {
        return [];
      }

      final productsRef = await _productsRef();
      final query = productsRef.where(
        FieldPath.documentId,
        whereIn: productIds,
      );

      // 商品を取得
      final products = await _firestoreService.getCollection(
        query: query,
        useCacheFallback: true,
      );

      // productIdsの順序に合わせて商品を並べ替え
      final orderedProducts = <Product>[];
      final productMap = {for (var product in products) product.id: product};

      for (var id in productIds) {
        if (productMap.containsKey(id)) {
          orderedProducts.add(productMap[id]!);
        }
      }

      return orderedProducts;
    } catch (e) {
      throw RepositoryException('カートの商品取得に失敗しました', originalError: e);
    }
  }

  /// 特定の商品を取得（キャッシュフォールバック付き）
  Future<Product?> fetchProduct(ProductID id) async {
    try {
      final productRef = await _productRef(id);
      return await _firestoreService.getDocument(
        docRef: productRef,
        useCacheFallback: true,
      );
    } catch (e) {
      throw RepositoryException('商品の取得に失敗しました', originalError: e);
    }
  }

  /// 特定のキーワードで商品を検索
  Future<List<Product>> searchProducts(String keyword) async {
    try {
      // 注: Firestoreの基本機能ではテキスト検索が限られているため、
      // 実際の実装ではAlgoliaなどの検索サービスを検討することをお勧めします
      final productsRef = await _productsRef();
      final query = productsRef
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
      final productsRef = await _productsRef();
      final query = productsRef
          .where("isVisible", isEqualTo: true)
          .where("isFeatured", isEqualTo: true)
          .limit(limit);

      return await _firestoreService.getCollection(
        query: query,
        useCacheFallback: true,
      );
    } catch (e) {
      throw RepositoryException('おすすめ商品の取得に失敗しました', originalError: e);
    }
  }
}

//+++++Provider+++++

@Riverpod(keepAlive: true)
ProductsRepository productsRepository(Ref ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return ProductsRepository(FirebaseFirestore.instance, firestoreService, ref);
}

/// カテゴリ内の商品を取得するProvider
@riverpod
Future<List<Product>> productsInCategory(Ref ref, CategoryID categoryId) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductsInCategory(categoryId);
}

///カート内の全商品を取得
@riverpod
Future<List<Product>> productsByIds(Ref ref, List<ProductID> productIds) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductsByIds(productIds);
}

/// 特定の商品を取得するProvider
@riverpod
Future<Product?> product(Ref ref, ProductID id) async {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProduct(id);
}

/// おすすめ商品を取得するProvider
@riverpod
Future<List<Product>> featuredProducts(Ref ref, {int limit = 10}) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.getFeaturedProducts(limit: limit);
}

/// 商品検索Provider
@riverpod
Future<List<Product>> searchProducts(Ref ref, String keyword) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.searchProducts(keyword);
}
