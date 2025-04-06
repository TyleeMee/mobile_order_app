import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_order_app/src/common_widgets/async_value_widget.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/features/categories/domain/category.dart';
import 'package:mobile_order_app/src/features/products/application/products_service.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';
import 'package:mobile_order_app/src/features/products/presentation/product_card.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';
import 'package:mobile_order_app/src/routing/app_router.dart';

class ProductsGrid extends ConsumerWidget {
  const ProductsGrid({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsValue = ref.watch(
      sortedProductsInCategoryProvider(category.id),
    );

    //TODO 不要になったら削除
    // デバッグ用プリント
    if (productsValue.hasError) {
      debugPrint('Products error: ${productsValue.error}');
      // debugPrint('Stack trace: ${categoriesValue.stackTrace}');
    }

    return AsyncValueWidget<List<Product>>(
      value: productsValue,
      data:
          (products) =>
              products.isNotEmpty
                  ? GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      Sizes.p16,
                      Sizes.p16,
                      Sizes.p16,
                      //*bottom paddingはProductSListScreenでGoToCartWidgetに合わせて設定
                      0,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2列のグリッド
                          childAspectRatio: 3 / 4, // 縦横比
                          crossAxisSpacing: Sizes.p8, // 水平方向のスペース
                          mainAxisSpacing: Sizes.p8, // 垂直方向のスペース
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onPressed:
                            () => context.goNamed(
                              AppRoute.product.name,
                              pathParameters: {'id': product.id},
                            ),
                      );
                    },
                  )
                  : Center(
                    child: Text(
                      '現在、${category.title}に\n購入できる商品はございません。\n今しばらくお待ちください。'
                          .hardcoded,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
    );
  }
}
