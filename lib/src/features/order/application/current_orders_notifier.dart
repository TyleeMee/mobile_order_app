import 'package:mobile_order_app/src/models/order.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_orders_notifier.g.dart';

@riverpod
class CurrentOrdersNotifier extends _$CurrentOrdersNotifier {
  @override
  List<Order> build() {
    return [];
  }

  List<Order> addOrder(Order order) {
    state = [...state, order];
    return state;
  }

  Order? getOrderById(String orderId) {
    final matchingOrders = state.where((order) => order.id == orderId).toList();
    return matchingOrders.isNotEmpty ? matchingOrders.first : null;
  }

  void removeOrderId(String orderId) {
    state = state.where((order) => order.id != orderId).toList();
  }

  void clearOrderIds() {
    state = [];
  }
}
