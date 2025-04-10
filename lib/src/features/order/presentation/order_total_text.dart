import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';
import 'package:mobile_order_app/src/utils/currency_formatter.dart';

class OrderTotalText extends StatelessWidget {
  const OrderTotalText({super.key, required this.total});
  final double total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p12),
      child: Row(
        children: [
          Text('合計'.hardcoded, style: Theme.of(context).textTheme.titleLarge),
          gapW8,
          Builder(
            builder: (context) {
              return Consumer(
                builder: (context, ref, child) {
                  final totalFormatted = ref
                      .watch(currencyFormatterProvider)
                      .format(total);
                  return Text(
                    totalFormatted,
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
