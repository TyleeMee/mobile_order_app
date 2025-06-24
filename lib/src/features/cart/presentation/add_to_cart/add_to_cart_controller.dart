import 'package:flutter/material.dart';
import 'package:mobile_order_app/src/features/cart/application/cart_notifier.dart';
import 'package:mobile_order_app/src/features/cart/domain/item.dart';
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

  void addItem(BuildContext context, ProductID productId) {
    final item = Item(productId: productId, quantity: state);
    ref.read(cartNotifierProvider.notifier).addItem(item);
    // 前の画面に戻る（contextが有効な場合）
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
