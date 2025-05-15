import 'package:flutter/material.dart';
import 'package:mobile_order_app/src/common_widgets/colored_headline.dart';
import 'package:mobile_order_app/src/common_widgets/custom_image.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';
import 'package:mobile_order_app/src/models/shop.dart';

class ShopInfoWidget extends StatelessWidget {
  const ShopInfoWidget({super.key, required this.shop});
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ColoredHeadline(child: Text('受け取り予定の店舗'.hardcoded)),
        Padding(
          padding: const EdgeInsets.all(Sizes.p12),
          child: Row(
            children: [
              Flexible(child: CustomImage(imageUrl: shop.imageUrl)),
              gapW16,
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shop.title),
                    gapH12,
                    Padding(
                      padding: const EdgeInsets.only(left: Sizes.p12),
                      child: Text(
                        '${shop.prefecture.displayName}${shop.city}${shop.streetAddress}\n${shop.building ?? ''}',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
