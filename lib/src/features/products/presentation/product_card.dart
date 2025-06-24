import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/common_widgets/custom_image.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/models/product.dart';
import 'package:mobile_order_app/src/utils/currency_formatter.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.onPressed});

  final Product product;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Opacity(
      opacity: product.isOrderAccepting ? 1.0 : 0.7, // 利用不可の場合は透明度を下げる
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.p8),
          side: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
        elevation: 2.0,
        clipBehavior: Clip.antiAlias, // 角丸の内側に内容を収める
        child: Stack(
          children: [
            InkWell(
              onTap:
                  product.isOrderAccepting
                      ? onPressed
                      : null, // 利用不可の場合はタップできないようにする
              child: Padding(
                padding: const EdgeInsets.all(Sizes.p12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 商品画像
                    CustomImage(imageUrl: product.imageUrl),
                    gapH8,
                    Text(
                      product.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(flex: 1),
                    Consumer(
                      builder: (context, ref, _) {
                        final priceFormatted = ref
                            .watch(currencyFormatterProvider)
                            .format(product.price);
                        return Text(
                          priceFormatted,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: textTheme.titleLarge,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // 利用不可の場合のオーバーレイ
            if (!product.isOrderAccepting)
              Positioned.fill(child: _buildUnavailableOverlay(context)),
          ],
        ),
      ),
    );
  }

  // 利用不可時のオーバーレイウィジェット
  Widget _buildUnavailableOverlay(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(102), // 0.4に相当する透明度をalpha値(0-255)で指定
        borderRadius: BorderRadius.circular(Sizes.p4),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p12,
            vertical: Sizes.p8,
          ),
          decoration: BoxDecoration(
            color: Colors.red.withAlpha(204), // 0.8に相当する透明度をalpha値(0-255)で指定
            borderRadius: BorderRadius.circular(Sizes.p4),
          ),
          child: const Text(
            '受付停止中',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
