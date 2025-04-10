import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/common_widgets/async_value_widget.dart';
import 'package:mobile_order_app/src/common_widgets/multi_async_value_widget.dart';
import 'package:mobile_order_app/src/common_widgets/responsive_center.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/features/cart/application/cart_notifier.dart';
import 'package:mobile_order_app/src/features/cart/presentation/cart_item_card.dart';
import 'package:mobile_order_app/src/features/cart/presentation/cart_total_text.dart';
import 'package:mobile_order_app/src/features/checkout/presentation/payment_widget.dart';
import 'package:mobile_order_app/src/features/products/data/products_repository.dart';
import 'package:mobile_order_app/src/features/shop/data/shop_repository.dart';
import 'package:mobile_order_app/src/features/shop/presentation/shop_info_widget.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ご注文内容の確定'.hardcoded)),
      body: Consumer(
        builder: (context, ref, child) {
          final shopValue = ref.watch(shopProvider);
          final cart = ref.watch(cartNotifierProvider);
          final productIds = ref.watch(cartProductIdsProvider);
          final productsValue = ref.watch(productsByIdsProvider(productIds));

          return SingleChildScrollView(
            child: MultiAsyncValueWidget(
              asyncValues: [shopValue, productsValue],
              data: () {
                final shop = shopValue.value;
                final products = productsValue.value!;
                return ResponsiveCenter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (shop != null) ShopInfoWidget(shop: shop),
                      PaymentWidget(cart: cart),
                      Padding(
                        padding: const EdgeInsets.all(Sizes.p16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ご請求額'.hardcoded),
                            gapW8,
                            CartTotalText(),
                          ],
                        ),
                      ),
                      for (var product in products)
                        CartItemCard(
                          product: product,
                          quantity: cart.items[product.id]!,
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
