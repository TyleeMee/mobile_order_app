import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_order_app/src/common_widgets/primary_button.dart';
import 'package:mobile_order_app/src/common_widgets/responsive_center.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/features/cart/presentation/cart_total_text.dart';
import 'package:mobile_order_app/src/features/cart/presentation/go_to_cart/go_to_cart_icon.dart';
import 'package:mobile_order_app/src/routing/app_router.dart';

class GoToCartWidget extends StatelessWidget {
  const GoToCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            const ShoppingCartIcon(),
            gapW8,
            const CartTotalText(),
            gapW16,
            Expanded(
              child: PrimaryButton(
                text: 'カートを確認して\nレジに進む',
                onPressed: () => context.goNamed(AppRoute.cart.name),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
