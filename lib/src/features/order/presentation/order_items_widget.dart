import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/common_widgets/colored_headline.dart';
import 'package:mobile_order_app/src/common_widgets/custom_image.dart';
import 'package:mobile_order_app/src/constants/app_color.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/features/order/domain/order.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';
import 'package:mobile_order_app/src/utils/currency_formatter.dart';

class OrderItemsWidget extends StatelessWidget {
  const OrderItemsWidget({
    super.key,
    required this.order,
    required this.products,
  });
  final Order order;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ColoredHeadline(child: Text('ご注文内容'.hardcoded)),
        for (var product in products)
          OrderItemListTile(order: order, product: product),
      ],
    );
  }
}

class OrderItemListTile extends StatelessWidget {
  const OrderItemListTile({
    super.key,
    required this.order,
    required this.product,
  });
  final Order order;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(product.title),
                  gapH12,
                  Row(
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          return Text(
                            ref
                                .watch(currencyFormatterProvider)
                                .format(product.price),
                            style: Theme.of(context).textTheme.titleLarge,
                          );
                        },
                      ),
                      gapW16,
                      Text(
                        '× ${order.items[product.id]}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: inactiveTextColorGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 100,
                child: CustomImage(imageUrl: product.imageUrl),
              ),
            ],
          ),
        ),
        const Divider(),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: Sizes.p12),
        //   child: Divider(height: 1, color: inactiveColorGrey),
        // ),
      ],
    );
  }
}
