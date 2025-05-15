import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/models/order.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import './api_client.dart';

part 'orders_service.g.dart';

class OrdersService {
  // 注文を作成するAPI
  static Future<Order?> createOrder(String ownerId, OrderData orderData) async {
    try {
      final response = await ApiClient.fetch(
        '/api/orders?ownerId=$ownerId',
        method: 'POST',
        body: orderData.toMap(),
      );
      if (response == null) {
        return null;
      }
      return Order.fromMap(response);
    } catch (error) {
      // エラーメッセージを出力
      debugPrint('注文作成エラー: $error');
      rethrow;
    }
  }

  // 注文IDで取得するAPI
  static Future<Order?> getOrder(String ownerId, String orderId) async {
    try {
      final response = await ApiClient.fetch(
        '/api/orders/$orderId?ownerId=$ownerId',
      );
      if (response == null) {
        return null;
      }
      return Order.fromMap(response);
    } catch (error) {
      // エラーメッセージが「APIエラー: 404」を含むか確認
      if (error.toString().contains('APIエラー: 404')) {
        return null;
      }
      rethrow;
    }
  }

  // 複数の注文IDから注文リストを取得するAPI
  static Future<List<Order>> getOrdersByIds(
    String ownerId,
    List<OrderID> orderIds,
  ) async {
    try {
      // クエリパラメータとしてorderIdsを送信
      final queryParams = orderIds.map((id) => 'ids=$id').join('&');
      final response = await ApiClient.fetch(
        '/api/orders?ownerId=$ownerId&$queryParams',
      );

      if (response == null) {
        return [];
      }

      // レスポンスが配列であることを確認
      if (response is List) {
        return response.map((item) => Order.fromMap(item)).toList();
      } else {
        // レスポンスが適切な形式でない場合は空のリストを返す
        return [];
      }
    } catch (error) {
      // エラーメッセージが「APIエラー: 404」を含むか確認
      if (error.toString().contains('APIエラー: 404')) {
        return [];
      }
      rethrow;
    }
  }

  // 注文ステータスを更新するAPI
  static Future<bool> updateOrderStatus(
    String ownerId,
    OrderID orderId,
    OrderStatus newStatus,
  ) async {
    try {
      final response = await ApiClient.fetch(
        '/api/orders/$orderId/status?ownerId=$ownerId',
        method: 'PUT',
        body: {'orderStatus': newStatus.toStorageString()},
      );

      // 成功した場合は200 OKが返るため、responseがnullでなければ成功
      return response != null;
    } catch (error) {
      // エラーメッセージを出力
      debugPrint('注文ステータス更新エラー: $error');
      return false;
    }
  }
}

//+++++Provider+++++

@riverpod
Future<Order?> order(Ref ref, OrderID orderId) async {
  final ownerId = await ref.watch(validOwnerIdProvider.future);
  return OrdersService.getOrder(ownerId, orderId);
}

@riverpod
Future<List<Order>> ordersByIds(Ref ref, List<OrderID> orderIds) async {
  final ownerId = await ref.watch(validOwnerIdProvider.future);
  return OrdersService.getOrdersByIds(ownerId, orderIds);
}

@riverpod
Future<Order?> createOrder(Ref ref, OrderData orderData) async {
  final ownerId = await ref.watch(validOwnerIdProvider.future);
  // 注: APIの実装によっては、orderDataにownerIdを設定する必要があるかもしれません
  return OrdersService.createOrder(ownerId, orderData);
}

@riverpod
Future<bool> updateOrderStatus(
  Ref ref, {
  required OrderID orderId,
  required OrderStatus newStatus,
}) async {
  final ownerId = await ref.watch(validOwnerIdProvider.future);
  return OrdersService.updateOrderStatus(ownerId, orderId, newStatus);
}
