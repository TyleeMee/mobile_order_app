import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_order_app/src/features/cart/domain/item.dart';

import 'package:mobile_order_app/src/features/products/domain/product.dart';

enum OrderStatus {
  newOrder('新規注文'),
  confirmed('確認済み'),
  canceled('キャンセル'),
  cooking('調理中'),
  prepared('準備完了'),
  served('提供済み');

  final String displayName;
  const OrderStatus(this.displayName);

  static OrderStatus fromDisplayName(String displayName) {
    return OrderStatus.values.firstWhere(
      (s) => s.displayName == displayName,
      orElse: () => throw ArgumentError('Invalid order status: $displayName'),
    );
  }

  // Firestoreに保存するための文字列を取得するメソッド
  String toStorageString() {
    return name; // enumの名前（英語）を返す
  }

  // Firestoreから取得した文字列からOrderStatusを復元するメソッド
  static OrderStatus fromStorageString(String storageString) {
    return OrderStatus.values.firstWhere(
      (s) => s.name == storageString,
      orElse:
          () =>
              throw ArgumentError(
                'Invalid order status string: $storageString',
              ),
    );
  }
}

typedef OrderID = String;
typedef PickupID = String;

//TODO 必要であれあば extends Equatableに
class Order {
  Order({
    required this.id,
    required this.pickupId,
    required this.items,
    required this.productIds,
    required this.orderStatus,
    required this.orderDate,
    required this.total,
  });
  final OrderID id;
  final PickupID pickupId;
  final Map<ProductID, int> items;
  final List<ProductID> productIds;
  final OrderStatus orderStatus;
  final DateTime orderDate;
  final double total;

  Order copyWith({
    OrderID? id,
    PickupID? pickupId,
    Map<ProductID, int>? items,
    List<ProductID>? productIds,
    OrderStatus? orderStatus,
    DateTime? orderDate,
    double? total,
  }) {
    return Order(
      id: id ?? this.id,
      pickupId: pickupId ?? this.pickupId,
      items: items ?? this.items,
      productIds: productIds ?? this.productIds,
      orderStatus: orderStatus ?? this.orderStatus,
      orderDate: orderDate ?? this.orderDate,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'pickupId': pickupId});
    result.addAll({'items': items});
    result.addAll({'productIds': productIds});
    result.addAll({'orderStatus': orderStatus.toStorageString()});
    result.addAll({'orderDate': orderDate.millisecondsSinceEpoch});
    result.addAll({'total': total});

    return result;
  }

  Map<String, dynamic> toFirestoreMap() {
    final result = <String, dynamic>{};

    result.addAll({'pickupId': pickupId});
    result.addAll({'items': items});
    result.addAll({'productIds': productIds});
    result.addAll({'orderStatus': orderStatus.toStorageString()});
    result.addAll({'orderDate': orderDate.millisecondsSinceEpoch});
    result.addAll({'total': total});

    return result;
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      pickupId: map['pickupId'],
      items: Map<ProductID, int>.from(map['items']),
      productIds: List<ProductID>.from(map['productIds']),
      orderStatus: OrderStatus.fromStorageString(map['orderStatus']),
      orderDate: DateTime.fromMillisecondsSinceEpoch(map['orderDate']),
      total: map['total']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, pickupId: $pickupId, items: $items, productIds: $productIds, orderStatus: $orderStatus, orderDate: $orderDate, total: $total)';
  }
}

extension OrderItems on Order {
  List<Item> toItemsList() {
    return items.entries
        .map((entry) => Item(productId: entry.key, quantity: entry.value))
        .toList();
  }
}

class OrderData {
  OrderData({
    required this.pickupId,
    required this.items,
    required this.productIds,
    required this.orderStatus,
    required this.orderDate,
    required this.total,
  });
  final PickupID pickupId;
  final Map<ProductID, int> items;
  final List<ProductID> productIds;
  final OrderStatus orderStatus;
  final DateTime orderDate;
  final double total;

  OrderData copyWith({
    PickupID? pickupId,
    Map<ProductID, int>? items,
    List<ProductID>? productIds,
    OrderStatus? orderStatus,
    DateTime? orderDate,
    double? total,
  }) {
    return OrderData(
      pickupId: pickupId ?? this.pickupId,
      items: items ?? this.items,
      productIds: productIds ?? this.productIds,
      orderStatus: orderStatus ?? this.orderStatus,
      orderDate: orderDate ?? this.orderDate,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pickupId': pickupId});
    result.addAll({'items': items});
    result.addAll({'productIds': productIds});
    result.addAll({'orderStatus': orderStatus.toStorageString()});
    result.addAll({'orderDate': orderDate.millisecondsSinceEpoch});
    result.addAll({'total': total});

    return result;
  }

  Map<String, dynamic> toFirestoreMap() {
    final result = <String, dynamic>{};

    result.addAll({'pickupId': pickupId});
    result.addAll({'items': items});
    result.addAll({'productIds': productIds});
    result.addAll({'orderStatus': orderStatus.toStorageString()});
    result.addAll({'orderDate': Timestamp.fromDate(orderDate)});
    result.addAll({'total': total});

    return result;
  }

  factory OrderData.fromMap(Map<String, dynamic> map) {
    return OrderData(
      pickupId: map['pickupId'],
      items: Map<ProductID, int>.from(map['items']),
      productIds: List<ProductID>.from(map['productIds']),
      orderStatus: OrderStatus.fromStorageString(map['orderStatus']),
      orderDate: DateTime.fromMillisecondsSinceEpoch(map['orderDate']),
      total: map['total']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderData.fromJson(String source) =>
      OrderData.fromMap(json.decode(source));
}
