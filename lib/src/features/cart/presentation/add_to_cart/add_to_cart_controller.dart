import 'dart:async';

import 'package:mobile_order_app/src/features/cart/application/cart_notifier.dart';
import 'package:mobile_order_app/src/features/cart/domain/item.dart';
import 'package:mobile_order_app/src/features/cart/domain/mutable_cart.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_to_cart_controller.g.dart';

@riverpod
class AddToCartController extends _$AddToCartController {
  @override
  int build() {
    return 1;
  }

  void updateQuantity(int quantity) {
    state = quantity;
  }

  Future<void> addItem(ProductID productId) async {
    final cart = ref.read(cartNotifierProvider);
    final item = Item(productId: productId, quantity: state);
    cart.addItem(item);
  }
}
