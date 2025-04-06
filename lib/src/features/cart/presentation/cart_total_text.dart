import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/constants/app_color.dart';
import 'package:mobile_order_app/src/features/cart/application/cart_notifier.dart';
import 'package:mobile_order_app/src/utils/currency_formatter.dart';
import 'package:shimmer/shimmer.dart';

class CartTotalText extends ConsumerWidget {
  const CartTotalText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartTotalValue = ref.watch(cartTotalProvider);
    return cartTotalValue.when(
      data: (total) {
        final cartTotalFormatted = ref
            .watch(currencyFormatterProvider)
            .format(total);
        return Text(
          cartTotalFormatted,
          style: Theme.of(context).textTheme.headlineSmall,
        );
      },
      loading:
          () => SizedBox(
            width: 64,
            height: 24,
            child: Shimmer.fromColors(
              baseColor: shimmerBaseColor!,
              highlightColor: shimmerHighlightColor!,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
              ),
            ),
          ),
      error:
          (_, __) =>
              Text('¥0', style: Theme.of(context).textTheme.headlineSmall),
    );
  }
}
