import 'package:equatable/equatable.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';

/// カートに追加できる数量付きの商品
class Item extends Equatable {
  const Item({required this.productId, required this.quantity});
  final ProductID productId;
  final int quantity;

  @override
  List<Object?> get props => [productId, quantity];

  @override
  bool? get stringify => true;
}
