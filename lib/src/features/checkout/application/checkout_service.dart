import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/features/cart/application/cart_notifier.dart';
import 'package:mobile_order_app/src/features/cart/domain/cart.dart';
import 'package:mobile_order_app/src/features/order/application/current_orders_notifier.dart';
import 'package:mobile_order_app/src/features/order/data/orders_repository.dart';
import 'package:mobile_order_app/src/features/order/domain/order.dart';
import 'package:mobile_order_app/src/features/products/data/products_repository.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';
import 'package:mobile_order_app/src/utils/generate_random_code.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checkout_service.g.dart';

class CheckoutService {
  CheckoutService(
    this._cart,
    this._ordersRepository,
    this._productsRepository,
    this._ref,
  );
  final Cart _cart;
  final OrdersRepository _ordersRepository;
  final ProductsRepository _productsRepository;
  final Ref _ref;

  Future<Order?> placeOrder() async {
    if (_cart.items.isNotEmpty) {
      // カートの内容をローカル変数にコピー（状態更新前に取得）
      final cartItems = Map<String, int>.from(_cart.items);
      final productIds = cartItems.keys.toList();
      final pickupId = generateRandomCode();
      final total = await _totalPrice(_cart);
      final orderData = OrderData(
        pickupId: pickupId,
        items: cartItems,
        productIds: productIds,
        orderStatus: OrderStatus.newOrder,
        orderDate: DateTime.now(),
        total: total,
      );
      final order = await _ordersRepository.addOrder(orderData);
      //addOrderが完了したら、カートを空にする。
      // _ref.read(cartNotifierProvider.notifier).resetCart();
      // 少し遅延を入れて状態更新が完了するのを待つ
      //* cartNotifierProvierの状態更新中にcurrentOrdersNotifierProiderを操作するとエラー
      //currentOrderIdsNotifierにorderIdを追加する。
      final orders = _ref
          .read(currentOrdersNotifierProvider.notifier)
          .addOrder(order);
      debugPrint(orders.toString());
      await Future.delayed(const Duration(milliseconds: 50));
      return order;
    } else {
      throw StateError('カートが空の場合は注文できません'.hardcoded);
    }
  }

  Future<double> _totalPrice(Cart cart) async {
    double total = 0.0;

    if (cart.items.isEmpty) {
      return 0.0;
    }

    // 各商品IDと数量について、価格情報を取得して合計を計算
    for (final entry in cart.items.entries) {
      final productId = entry.key;
      final quantity = entry.value;

      // 商品情報を非同期で取得
      final product = await _productsRepository.fetchProduct(productId);

      // 商品情報が取得できた場合のみ計算に追加
      if (product != null) {
        total += product.price * quantity;
      }
    }

    return total;
  }
}

@Riverpod(keepAlive: true)
CheckoutService checkoutService(Ref ref) {
  final cart = ref.watch(cartNotifierProvider);
  final ordersRepository = ref.watch(ordersRepositoryProvider);
  final productsRepository = ref.watch(productsRepositoryProvider);
  return CheckoutService(cart, ordersRepository, productsRepository, ref);
}
