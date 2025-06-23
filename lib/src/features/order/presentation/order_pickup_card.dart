import 'package:flutter/material.dart';
import 'package:flutter/material.dart' show Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';
import 'package:mobile_order_app/src/models/order.dart';
import 'package:mobile_order_app/src/utils/date_formatter.dart';

class OrderPickupCard extends StatelessWidget {
  const OrderPickupCard({super.key, required this.order, this.onPressed});
  final Order order;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p12),
      child: Card(
        elevation: 10,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      'ご注文の商品'.hardcoded,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    gapH12,
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final dateWithYear = ref.watch(
                          dateWithYearProvider(order.orderDate),
                        );
                        return Text(
                          dateWithYear,
                          style: Theme.of(context).textTheme.titleMedium,
                        );
                      },
                    ),
                    Column(
                      children: [
                        Text(
                          '受け取り番号'.hardcoded,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          order.pickupId,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
