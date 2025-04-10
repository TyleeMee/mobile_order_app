import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_order_app/src/common_widgets/async_value_widget.dart';
import 'package:mobile_order_app/src/common_widgets/decorated_box_with_shadow.dart';
import 'package:mobile_order_app/src/common_widgets/multi_async_value_widget.dart';
import 'package:mobile_order_app/src/common_widgets/primary_button.dart';
import 'package:mobile_order_app/src/common_widgets/responsive_center.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/features/order/application/current_orders_notifier.dart';
import 'package:mobile_order_app/src/features/order/data/orders_repository.dart';
import 'package:mobile_order_app/src/features/order/domain/order.dart';
import 'package:mobile_order_app/src/features/order/presentation/empty_order_view.dart';
import 'package:mobile_order_app/src/features/order/presentation/order_items_widget.dart';
import 'package:mobile_order_app/src/features/order/presentation/order_pickup_card.dart';
import 'package:mobile_order_app/src/features/order/presentation/order_total_text.dart';
import 'package:mobile_order_app/src/features/products/data/products_repository.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';
import 'package:mobile_order_app/src/routing/app_router.dart';
import 'package:mobile_order_app/src/utils/currency_formatter.dart';

class CurrentOrderScreen extends StatelessWidget {
  const CurrentOrderScreen({super.key, required this.orderId});
  final OrderID orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ご注文ありがとうございます'.hardcoded)),
      body: Consumer(
        builder: (context, ref, child) {
          final orderValue = ref.watch(orderProvider(orderId));
          return AsyncValueWidget(
            value: orderValue,
            data: (order) {
              if (order == null) {
                return EmptyOrderView();
              } else {
                final productsValue = ref.watch(
                  productsByIdsProvider(order.productIds),
                );
                return Stack(
                  children: [
                    Positioned.fill(
                      bottom: 70,
                      child: SingleChildScrollView(
                        child: AsyncValueWidget(
                          value: productsValue,
                          data: (products) {
                            return CurrentOrderDetails(
                              order: order,
                              products: products,
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: DecoratedBoxWithShadow(
                        child: ResponsiveCenter(
                          child: SizedBox(
                            width: double.infinity,
                            child: PrimaryButton(
                              text: '商品を受け取りました',
                              onPressed:
                                  () => _showConfirmationDialog(
                                    context,
                                    ref,
                                    order,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}

class CurrentOrderDetails extends StatelessWidget {
  const CurrentOrderDetails({
    super.key,
    required this.order,
    required this.products,
  });
  final Order order;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OrderPickupCard(order: order),
          Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: OutlinedButton(
              onPressed: () => context.goNamed(AppRoute.home.name),
              child: Text('ホーム画面に戻る'.hardcoded),
            ),
          ),
          OrderTotalText(total: order.total),
          const Divider(),
          OrderItemsWidget(order: order, products: products),
          // ColoredBox(
          //   color: inactiveColorLightGrey,
          //   child: const SizedBox(height: Sizes.p32),
          // ),
        ],
      ),
    );
  }
}

void _showConfirmationDialog(BuildContext context, WidgetRef ref, Order order) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '商品を受け取り済みにすると、受け取り番号は再表示できません',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Sizes.p24),
            PrimaryButton(
              text: '受け取り済みにする',
              onPressed: () async {
                // Orderをユーザー画面から削除
                ref
                    .read(currentOrdersNotifierProvider.notifier)
                    .removeOrderId(order.id);
                //orderStatusをservedに更新
                ref
                    .read(ordersRepositoryProvider)
                    .updateOrderStatus(order.id, OrderStatus.served);
                await Future.delayed(const Duration(milliseconds: 200));
                // async操作後にmountedチェックを行う
                if (!context.mounted) return;
                //マウントされている場合のみBuildContextを使用する
                Navigator.of(context).pop();
                // 処理完了後、ホーム画面などに遷移
                context.goNamed(AppRoute.home.name);
              },
            ),
            const SizedBox(height: Sizes.p16),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text('キャンセル'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
