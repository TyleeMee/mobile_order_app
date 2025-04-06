import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/constants/app_color.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/features/cart/application/cart_notifier.dart';

class ShoppingCartIcon extends ConsumerWidget {
  const ShoppingCartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemsCount = ref.watch(cartItemsCountProvider);
    return Stack(
      alignment: Alignment.topRight,
      children: [
        const SizedBox(
          width: 56,
          height: 56,
          child: Icon(Icons.shopping_cart, size: Sizes.p32),
        ),
        Positioned(child: ShoppingCartIconBadge(itemsCount: cartItemsCount)),
      ],
    );
  }
}

class ShoppingCartIconBadge extends StatelessWidget {
  const ShoppingCartIconBadge({super.key, required this.itemsCount});
  final int itemsCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.p24,
      height: Sizes.p24,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: accentColor,
        ),
        child: Text(
          '$itemsCount',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.p16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
