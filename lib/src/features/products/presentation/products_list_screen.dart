import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/common_widgets/async_value_ui.dart';
import 'package:mobile_order_app/src/common_widgets/async_value_widget.dart';
import 'package:mobile_order_app/src/common_widgets/decorated_box_with_shadow.dart';
import 'package:mobile_order_app/src/common_widgets/responsive_center.dart';
import 'package:mobile_order_app/src/constants/app_color.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/constants/breakpoints.dart';
import 'package:mobile_order_app/src/features/cart/application/cart_notifier.dart';
import 'package:mobile_order_app/src/features/cart/presentation/go_to_cart/go_to_cart_widget.dart';
import 'package:mobile_order_app/src/features/categories/application/categories_service.dart';
import 'package:mobile_order_app/src/features/categories/domain/category.dart';
import 'package:mobile_order_app/src/features/products/presentation/products_grid.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';

class ProductsListScreen extends ConsumerWidget {
  const ProductsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesValue = ref.watch(sortedCategoriesFutureProvider);
    final cart = ref.watch(cartNotifierProvider);
    final double bottomPadding = cart.items.isNotEmpty ? 86 : 0;

    // デバッグ用プリント
    if (categoriesValue.hasError) {
      debugPrint('Categories error: ${categoriesValue.error}');
      // debugPrint('Stack trace: ${categoriesValue.stackTrace}');
    }

    // AsyncValueの状態変化を監視し、エラー時にアラートダイアログを表示
    ref.listen<AsyncValue<List<Category>>>(
      sortedCategoriesFutureProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    return Scaffold(
      appBar: AppBar(title: Text('メニュー'.hardcoded), elevation: 0),
      body: AsyncValueWidget<List<Category>>(
        value: categoriesValue,
        data: (categories) {
          if (categories.isEmpty) {
            return Center(
              child: Text(
                '現在、購入できる商品はございません。\n今しばらくお待ちください。'.hardcoded,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          }

          final tabsHorizontalPadding =
              MediaQuery.of(context).size.width < Breakpoint.tablet
                  ? 0.0
                  : (MediaQuery.of(context).size.width - Breakpoint.tablet) / 2;
          return DefaultTabController(
            length: categories.length,
            child: Stack(
              children: [
                Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: accentColor,
                      tabAlignment: TabAlignment.startOffset,
                      // タブの位置を調整
                      padding: EdgeInsets.symmetric(
                        horizontal: tabsHorizontalPadding,
                      ),
                      tabs:
                          categories
                              .map((category) => Tab(text: category.title))
                              .toList(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          //bottomは、Stackでカート操作エリアと重なる分だけ余白を空ける
                          bottom: bottomPadding,
                        ),
                        //TODO 画面拡大時に、scrollBarを画面右端に表示できるようにする
                        child: ResponsiveCenter(
                          child: TabBarView(
                            children:
                                categories
                                    .map(
                                      (category) =>
                                          ProductsGrid(category: category),
                                    )
                                    .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (cart.items.isNotEmpty)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: DecoratedBoxWithShadow(child: GoToCartWidget()),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
