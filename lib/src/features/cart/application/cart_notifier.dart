import 'package:mobile_order_app/src/features/cart/domain/cart.dart';
import 'package:mobile_order_app/src/features/cart/domain/item.dart';
import 'package:mobile_order_app/src/features/cart/domain/mutable_cart.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_notifier.g.dart';

@Riverpod(keepAlive: true)
class CartNotifier extends _$CartNotifier {
  @override
  Cart build() {
    return const Cart();
  }

  // 商品を追加
  void addItem(Item item) {
    state = state.addItem(item);
  }

  // 商品の数量を更新
  void setItem(Item item) {
    state = state.setItem(item);
  }

  // 商品を削除
  void removeItem(ProductID productId) {
    state = state.removeItemById(productId);
  }
}
