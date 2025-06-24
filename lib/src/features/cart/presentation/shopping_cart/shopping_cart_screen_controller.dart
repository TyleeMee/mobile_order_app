import 'package:mobile_order_app/src/features/cart/application/cart_notifier.dart';
import 'package:mobile_order_app/src/features/cart/domain/item.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shopping_cart_screen_controller.g.dart';

@riverpod
class ShoppingCartScreenController extends _$ShoppingCartScreenController {
  @override
  FutureOr<void> build() {
    // nothing to do = AsyncData(null)
  }

  // CartService get cartService => ref.read(cartServiceProvider);

  void updateQuantity(ProductID productId, int quantity) async {
    final updated = Item(productId: productId, quantity: quantity);
    ref.read(cartNotifierProvider.notifier).setItem(updated);
  }

  Future<void> removeItemById(ProductID productId) async {
    ref.read(cartNotifierProvider.notifier).removeItemById(productId);
  }
}
