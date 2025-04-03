import 'package:mobile_order_app/src/features/cart/domain/cart.dart';
import 'package:mobile_order_app/src/features/cart/domain/item.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';

/// ショッピングカート内のアイテムを変更するためのヘルパー拡張
extension MutableCart on Cart {
  /// アイテムをカートに追加する。ただし、すでに存在する場合は既存の数量を上書きする。
  Cart setItem(Item item) {
    final copy = Map<ProductID, int>.from(items);
    copy[item.productId] = item.quantity;
    return Cart(copy);
  }

  // アイテムをカートに追加する。ただし、すでに存在する場合は既存の数量にitemの数量を追加する。
  Cart addItem(Item item) {
    final copy = Map<ProductID, int>.from(items);
    copy.update(
      item.productId,
      // すでに値が存在する場合は、itemの数量を既存の数量に加算して更新する
      (value) => item.quantity + value,
      // 値が存在しない場合は、新たにitemをカートに追加する
      ifAbsent: () => item.quantity,
    );
    return Cart(copy);
  }

  // アイテムListをカートに追加する。ただし、すでに存在する場合は既存の数量にitemの数量を追加する。
  Cart addItems(List<Item> itemsToAdd) {
    final copy = Map<ProductID, int>.from(items);
    for (var item in itemsToAdd) {
      copy.update(
        item.productId,
        // すでに値が存在する場合は、itemの数量を既存の数量に加算して更新する
        (value) => item.quantity + value,
        // 値が存在しない場合は、新たにitemをカートに追加する
        ifAbsent: () => item.quantity,
      );
    }
    return Cart(copy);
  }

  /// 該当のProductがカートに存在すれば、itemを削除
  Cart removeItemById(ProductID productId) {
    final copy = Map<ProductID, int>.from(items);
    copy.remove(productId);
    return Cart(copy);
  }
}
