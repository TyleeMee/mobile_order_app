import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/features/cart/domain/cart.dart';
import 'package:mobile_order_app/src/features/cart/domain/item.dart';
import 'package:mobile_order_app/src/features/cart/domain/mutable_cart.dart';
import 'package:mobile_order_app/src/models/product.dart';
import 'package:mobile_order_app/src/services/products_service.dart';
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
  void removeItemById(ProductID productId) {
    state = state.removeItemById(productId);
  }

  //全ての商品を削除
  void resetCart() {
    state = const Cart();
  }

  int getCartItemsCount() {
    return state.items.values.fold(0, (value, element) => value + element);
  }
}

@riverpod
int cartItemsCount(Ref ref) {
  final cart = ref.watch(cartNotifierProvider);
  return cart.items.values.fold(0, (value, element) => value + element);
}

@riverpod
Future<double> cartTotal(Ref ref) async {
  final cart = ref.watch(cartNotifierProvider);
  double total = 0.0;

  // 各商品IDと数量について、価格情報を取得して合計を計算
  for (final entry in cart.items.entries) {
    final productId = entry.key;
    final quantity = entry.value;

    // 商品情報を非同期で取得
    final product = await ref.watch(productProvider(productId).future);

    // 商品情報が取得できた場合のみ計算に追加
    if (product != null) {
      total += product.price * quantity;
    }
  }

  return total;
}

///ショッピングカートのProductsリストに使用
//* UIコンポーネント内で直接 cart.items.keys.toList() のような
//* 新しいリスト参照を作成して Provider に渡すことは避ける→
//* リビルドの度に新たなリストが作成され、何回も呼び出される
@riverpod
List<ProductID> cartProductIds(Ref ref) {
  final cart = ref.watch(cartNotifierProvider);
  return cart.items.keys.toList();
}
