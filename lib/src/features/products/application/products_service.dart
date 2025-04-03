import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/features/categories/domain/category.dart';
import 'package:mobile_order_app/src/features/products/data/products_repository.dart';
import 'package:mobile_order_app/src/features/products/data/product_sequences_repository.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_service.g.dart';

class ProductsService {
  const ProductsService(
    this._productsRepository,
    this._productSequencesRepository,
  );
  final ProductsRepository _productsRepository;
  final ProductSequencesRepository _productSequencesRepository;

  /// カテゴリ内の商品を並び順で取得する関数
  Future<List<Product>> getSortedProductsInCategory(
    CategoryID categoryId,
  ) async {
    // 商品データと順序情報を並行して取得
    final products = await _productsRepository.fetchProductsInCategory(
      categoryId,
    );
    final sortedIds = await _productSequencesRepository
        .fetchProductSequenceInCategory(categoryId);

    // 順序情報がない場合はデフォルトの順序（更新日時など）で商品を返す
    if (sortedIds.isEmpty) {
      return products..sort((a, b) => b.updated.compareTo(a.updated));
    }

    // 商品をマップに変換して検索を効率化
    final productMap = {for (final product in products) product.id: product};

    // 指定された順序で商品を並び替え
    final sortedProducts =
        sortedIds
            .where((id) => productMap.containsKey(id)) // 存在する商品のみフィルタリング
            .map((id) => productMap[id]!)
            .toList();

    // 順序情報にない商品（新しく追加されたものなど）を末尾に追加
    final unsortedProducts =
        products.where((product) => !sortedIds.contains(product.id)).toList();

    return [...sortedProducts, ...unsortedProducts];
  }
}

// Provider
@Riverpod(keepAlive: true)
ProductsService productsService(Ref ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  final productSequencesRepository = ref.watch(
    productSequencesRepositoryProvider,
  );
  return ProductsService(productsRepository, productSequencesRepository);
}

// ソート済み商品のプロバイダー
@riverpod
Future<List<Product>> sortedProductsInCategoryFuture(
  Ref ref,
  CategoryID categoryId,
) {
  final productsService = ref.watch(productsServiceProvider);
  return productsService.getSortedProductsInCategory(categoryId);
}
