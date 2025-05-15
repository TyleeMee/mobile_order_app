import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/common_widgets/custom_image.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/features/cart/presentation/item_quantity_selector.dart';
import 'package:mobile_order_app/src/features/cart/presentation/shopping_cart/shopping_cart_screen_controller.dart';
import 'package:mobile_order_app/src/models/product.dart';
import 'package:mobile_order_app/src/utils/currency_formatter.dart';

class CartItemCard extends ConsumerWidget {
  const CartItemCard({
    super.key,
    required this.product,
    required this.quantity,
  });

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        gapH4,
        Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: Sizes.p64,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Sizes.p64,
                        width: Sizes.p64,
                        child: CustomImage(imageUrl: product.imageUrl),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade400),
                Row(
                  children: [
                    Text(
                      ref
                          .watch(currencyFormatterProvider)
                          .format(product.price),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: textTheme.titleLarge,
                    ),
                    const Spacer(),
                    // const Expanded(child: SizedBox(height: 0)),
                    OutlinedButton(
                      onPressed:
                          () => ref
                              .read(
                                shoppingCartScreenControllerProvider.notifier,
                              )
                              .removeItemById(product.id),
                      child: const Text('削除'),
                    ),
                    gapW8,
                    const SizedBox(
                      height: Sizes.p24,
                      child: VerticalDivider(color: Colors.grey),
                    ),
                    ItemQuantitySelector(
                      quantity: quantity,
                      maxQuantity: max(10, quantity),
                      onChanged:
                          (updatedQuantity) => ref
                              .read(
                                shoppingCartScreenControllerProvider.notifier,
                              )
                              .updateQuantity(product.id, updatedQuantity),
                      onChangedForDeletion:
                          () => ref
                              .read(
                                shoppingCartScreenControllerProvider.notifier,
                              )
                              .removeItemById(product.id),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        gapH4,
        Divider(
          color: Colors.grey.shade700,
          height: 0,
          indent: Sizes.p12,
          endIndent: Sizes.p12,
        ),
      ],
    );
  }
}
