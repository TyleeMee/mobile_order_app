import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/common_widgets/async_value_ui.dart';
import 'package:mobile_order_app/src/common_widgets/custom_image.dart';
import 'package:mobile_order_app/src/common_widgets/decorated_box_with_shadow.dart';
import 'package:mobile_order_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:mobile_order_app/src/common_widgets/reconnect_view.dart';
import 'package:mobile_order_app/src/common_widgets/responsive_center.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/features/cart/presentation/add_to_cart/add_to_cart_widget.dart';
import 'package:mobile_order_app/src/features/products/data/products_repository.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key, required this.productId});
  final ProductID productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productValue = ref.watch(productProvider(productId));
    // AsyncValueの状態変化を監視し、エラー時にアラートダイアログを表示
    ref.listen<AsyncValue<Product?>>(
      productProvider(productId),
      (_, state) => state.showAlertDialogOnError(context),
    );
    //* data取得時とerror/loading時でAppBarを変えたいので、AsyncValueWidgetを使用しない
    return productValue.when(
      error:
          (e, st) => Scaffold(
            appBar: AppBar(title: const Text('商品')),
            body: Center(child: ReconnectView()),
          ),
      loading:
          () => Scaffold(
            appBar: AppBar(title: const Text('商品')),
            body: Stack(
              children: [
                // オーバーレイ（全画面に透過する灰色背景）
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withAlpha(77),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            ),
          ),
      data:
          (product) =>
              product == null
                  ? Scaffold(
                    appBar: AppBar(title: const Text('商品')),
                    body: EmptyPlaceholderWidget(
                      message: '商品が見つかりませんでした'.hardcoded,
                    ),
                  )
                  : Scaffold(
                    appBar: AppBar(title: Text(product.title.hardcoded)),
                    body: Stack(
                      children: [
                        Positioned.fill(
                          bottom: 130,
                          child: SingleChildScrollView(
                            child: ProductDetails(product: product),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: DecoratedBoxWithShadow(
                            child: AddToCartWidget(product: product),
                          ),
                        ),
                      ],
                    ),
                  ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      //AddToCartと重ならないようにbottomに余白を設ける
      padding: const EdgeInsets.all(Sizes.p16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p32),
            child: CustomImage(imageUrl: product.imageUrl),
          ),
          gapH16,
          if (product.description != null)
            Text(
              product.description!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          gapH12,
        ],
      ),
    );
  }
}
