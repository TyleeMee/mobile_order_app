import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/common_widgets/primary_button.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/features/cart/presentation/add_to_cart/add_to_cart_controller.dart';
import 'package:mobile_order_app/src/features/cart/presentation/item_quantity_selector.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';
import 'package:mobile_order_app/src/utils/currency_formatter.dart';

class AddToCartWidget extends ConsumerWidget {
  const AddToCartWidget({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(addToCartControllerProvider);
    final priceFormatted = ref
        .watch(currencyFormatterProvider)
        .format(product.price);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              priceFormatted,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            ItemQuantitySelector(
              quantity: quantity,
              maxQuantity: 10,
              onChanged:
                  (quantity) => ref
                      .read(addToCartControllerProvider.notifier)
                      .updateQuantity(quantity),
            ),
          ],
        ),
        gapH12,
        PrimaryButton(text: 'カートに追加する'),
      ],
    );
  }
}
