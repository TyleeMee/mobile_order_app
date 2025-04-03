import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mobile_order_app/src/features/cart/domain/item.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';

class Cart extends Equatable {
  const Cart([this.items = const {}]);

  /// ショッピングカートの全商品のMap
  /// - key: product ID
  /// - value: quantity
  final Map<ProductID, int> items;

  //TODO firestoreから取得時にコード修正（必要であれば）
  //firestoreのデータをCartに変換
  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(Map<ProductID, int>.from(map['items']));
  }

  Map<String, dynamic> toMap() => {'items': items};

  //TODO　必要なければstringifyまで削除
  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [items];

  @override
  bool? get stringify => true;
}

extension CartItems on Cart {
  List<Item> toItemsList() {
    return items.entries.map((entry) {
      return Item(productId: entry.key, quantity: entry.value);
    }).toList();
  }
}
