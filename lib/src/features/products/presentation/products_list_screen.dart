import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/common_widgets/async_value_ui.dart';
import 'package:mobile_order_app/src/common_widgets/async_value_widget.dart';
import 'package:mobile_order_app/src/constants/app_color.dart';
import 'package:mobile_order_app/src/features/categories/application/categories_service.dart';
import 'package:mobile_order_app/src/features/categories/domain/category.dart';
import 'package:mobile_order_app/src/features/products/presentation/products_grid.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';

class ProductsListScreen extends ConsumerWidget {
  const ProductsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesValue = ref.watch(sortedCategoriesFutureProvider);

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
      appBar: AppBar(title: Text('メニュー'.hardcoded)),
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

          return DefaultTabController(
            length: categories.length,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: accentColor,
                  tabs:
                      categories
                          .map((category) => Tab(text: category.title))
                          .toList(),
                ),
                Expanded(
                  child: TabBarView(
                    children:
                        categories
                            .map((category) => ProductsGrid(category: category))
                            .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
