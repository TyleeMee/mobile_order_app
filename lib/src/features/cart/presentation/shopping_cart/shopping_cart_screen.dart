import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_order_app/src/common_widgets/async_value_widget.dart';
import 'package:mobile_order_app/src/common_widgets/primary_button.dart';
import 'package:mobile_order_app/src/common_widgets/responsive_center.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/features/cart/application/cart_notifier.dart';
import 'package:mobile_order_app/src/features/cart/presentation/cart_item_card.dart';
import 'package:mobile_order_app/src/features/cart/presentation/cart_total_text.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';
import 'package:mobile_order_app/src/models/product.dart';
import 'package:mobile_order_app/src/routing/app_router.dart';
import 'package:mobile_order_app/src/services/products_service.dart';

class ShoppingCartScreen extends ConsumerWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // cartItemsCountProviderをリッスンして、値が0になったら自動的にホーム画面に戻る
    ref.listen<int>(cartItemsCountProvider, (previous, current) {
      if (current == 0) {
        context.goNamed(AppRoute.home.name);
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text('カート'.hardcoded)),
      body: Consumer(
        builder: (context, ref, child) {
          final cart = ref.watch(cartNotifierProvider);
          final productIds = ref.watch(cartProductIdsProvider);
          final productsValue = ref.watch(productsByIdsProvider(productIds));

          // デバッグ用プリント
          if (productsValue.hasValue) {
            debugPrint('productsValue hasValue: $productsValue');
          }

          // デバッグ用プリント
          if (productsValue.hasError) {
            debugPrint('productsValue error: ${productsValue.error}');
          }

          return AsyncValueWidget<List<Product>>(
            value: productsValue,
            data: (products) {
              return Stack(
                children: [
                  //* CartItemsListを背面にしたいので、Stackの中で先に書く
                  //1,CartItemsList
                  SingleChildScrollView(
                    child: ResponsiveCenter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          Sizes.p16,
                          126,
                          Sizes.p16,
                          Sizes.p16,
                        ),
                        child: Column(
                          children: [
                            for (var product in products)
                              CartItemCard(
                                product: product,
                                quantity: cart.items[product.id]!,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // 2,「レジに進む」ボタンの下の影
                  Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade700,
                            offset: Offset(0, 1),
                            blurRadius: Sizes.p4,
                            spreadRadius: 1,
                          ),
                        ],
                        color: Colors.grey,
                      ),
                      child: SizedBox(height: 0.5),
                    ),
                  ),
                  // 3,小計と「レジに進む」ボタン
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 120,
                      child: ColoredBox(
                        color: Colors.white,
                        child: ResponsiveCenter(
                          padding: const EdgeInsets.fromLTRB(
                            Sizes.p16,
                            Sizes.p16,
                            Sizes.p16,
                            Sizes.p12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Text('小計'.hardcoded),
                                  gapW8,
                                  CartTotalText(),
                                ],
                              ),
                              gapH8,
                              Consumer(
                                builder: (context, ref, child) {
                                  final cartItemsCount = ref.watch(
                                    cartItemsCountProvider,
                                  );
                                  return PrimaryButton(
                                    text: 'レジに進む（$cartItemsCount個の商品）',
                                    onPressed:
                                        () => context.goNamed(
                                          AppRoute.checkout.name,
                                        ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
