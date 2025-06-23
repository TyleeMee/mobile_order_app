import 'dart:convert';

import 'package:mobile_order_app/src/features/cart/domain/item.dart';
import 'package:mobile_order_app/src/models/payment_intent.dart';

import 'package:mobile_order_app/src/models/product.dart';

enum OrderStatus {
  newOrder('新規注文'),
  paymentPending('決済待ち'), // 追加
  paymentFailed('決済失敗'), // 追加
  confirmed('確認済み'),
  canceled('キャンセル'),
  cooking('調理中'),
  prepared('準備完了'),
  served('提供済み'),
  refunded('返金済み'); // 追加

  final String displayName;
  const OrderStatus(this.displayName);

  static OrderStatus fromDisplayName(String displayName) {
    return OrderStatus.values.firstWhere(
      (s) => s.displayName == displayName,
      orElse: () => throw ArgumentError('Invalid order status: $displayName'),
    );
  }

  String toStorageString() {
    return name; // enumの名前（英語）を返す
  }

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
    required this.productTitles,
    // 決済関連フィールド（最小限）
    this.paymentIntentId,
    this.paymentMethodId,
    this.paymentStatus,
    this.chargeId,
    this.receiptUrl,
    this.refundId,
    this.paymentMetadata,
  });

  final OrderID id;
  final PickupID pickupId;
  final Map<ProductID, int> items;
  final List<ProductID> productIds;
  final OrderStatus orderStatus;
  final DateTime orderDate;
  final double total;
  final Map<ProductID, String> productTitles;

  // 決済関連フィールド（最小限）
  final String? paymentIntentId; // Stripe PaymentIntent ID
  final String? paymentMethodId; // 決済方法ID
  final PaymentStatus? paymentStatus; // 決済ステータス
  final String? chargeId; // Stripe Charge ID
  final String? receiptUrl; // 領収書URL
  final String? refundId; // 返金ID
  final PaymentMetadata? paymentMetadata; // 決済メタデータ

  factory Order.fromMap(Map<String, dynamic> map) {
    // タイムスタンプ変換用のヘルパー関数
    DateTime parseTimestamp(dynamic timestamp) {
      if (timestamp is int) {
        // UNIXタイムスタンプ（ミリ秒）
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      } else if (timestamp is String) {
        // ISO 8601形式の文字列
        return DateTime.parse(timestamp);
      } else {
        // 不明なフォーマットの場合は現在時刻をデフォルトとする
        return DateTime.now();
      }
    }

    return Order(
      id: map['id'],
      pickupId: map['pickupId'],
      items: Map<ProductID, int>.from(map['items']),
      productIds: List<ProductID>.from(map['productIds']),
      orderStatus: OrderStatus.fromStorageString(map['orderStatus']),
      orderDate: parseTimestamp(map['orderDate']),
      total: map['total']?.toDouble() ?? 0.0,
      productTitles: Map<ProductID, String>.from(map['productTitles'] ?? {}),
      // 決済関連フィールド
      paymentIntentId: map['paymentIntentId'],
      paymentMethodId: map['paymentMethodId'],
      paymentStatus:
          map['paymentStatus'] != null
              ? PaymentStatus.fromStorageString(map['paymentStatus'])
              : null,
      chargeId: map['chargeId'],
      receiptUrl: map['receiptUrl'],
      refundId: map['refundId'],
      paymentMetadata:
          map['paymentMetadata'] != null
              ? PaymentMetadata.fromMap(map['paymentMetadata'])
              : null,
    );
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
    // 決済関連（最小限）
    this.paymentIntentId,
    this.paymentMethodId,
    this.paymentStatus,
    this.chargeId,
    this.receiptUrl,
    this.refundId,
    this.paymentMetadata,
  });

  final PickupID pickupId;
  final Map<ProductID, int> items;
  final List<ProductID> productIds;
  final OrderStatus orderStatus;
  final DateTime orderDate;
  final double total;

  // 決済関連フィールド（最小限）
  final String? paymentIntentId;
  final String? paymentMethodId;
  final PaymentStatus? paymentStatus;
  final String? chargeId;
  final String? receiptUrl;
  final String? refundId;
  final PaymentMetadata? paymentMetadata;

  OrderData copyWith({
    PickupID? pickupId,
    Map<ProductID, int>? items,
    List<ProductID>? productIds,
    OrderStatus? orderStatus,
    DateTime? orderDate,
    double? total,
    String? paymentIntentId,
    String? paymentMethodId,
    PaymentStatus? paymentStatus,
    String? chargeId,
    String? receiptUrl,
    String? refundId,
    PaymentMetadata? paymentMetadata,
  }) {
    return OrderData(
      pickupId: pickupId ?? this.pickupId,
      items: items ?? this.items,
      productIds: productIds ?? this.productIds,
      orderStatus: orderStatus ?? this.orderStatus,
      orderDate: orderDate ?? this.orderDate,
      total: total ?? this.total,
      paymentIntentId: paymentIntentId ?? this.paymentIntentId,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      chargeId: chargeId ?? this.chargeId,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      refundId: refundId ?? this.refundId,
      paymentMetadata: paymentMetadata ?? this.paymentMetadata,
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

    // 決済関連フィールド（nullでない場合のみ追加）
    if (paymentIntentId != null) {
      result.addAll({'paymentIntentId': paymentIntentId});
    }
    if (paymentMethodId != null) {
      result.addAll({'paymentMethodId': paymentMethodId});
    }
    if (paymentStatus != null) {
      result.addAll({'paymentStatus': paymentStatus!.toStorageString()});
    }
    if (chargeId != null) {
      result.addAll({'chargeId': chargeId});
    }
    if (receiptUrl != null) {
      result.addAll({'receiptUrl': receiptUrl});
    }
    if (refundId != null) {
      result.addAll({'refundId': refundId});
    }
    if (paymentMetadata != null) {
      result.addAll({'paymentMetadata': paymentMetadata!.toMap()});
    }

    return result;
  }

  factory OrderData.fromMap(Map<String, dynamic> map) {
    // タイムスタンプ変換用のヘルパー関数
    DateTime parseTimestamp(dynamic timestamp) {
      if (timestamp is int) {
        // UNIXタイムスタンプ（ミリ秒）
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      } else if (timestamp is String) {
        // ISO 8601形式の文字列
        return DateTime.parse(timestamp);
      } else {
        // 不明なフォーマットの場合は現在時刻をデフォルトとする
        return DateTime.now();
      }
    }

    return OrderData(
      pickupId: map['pickupId'],
      items: Map<ProductID, int>.from(map['items']),
      productIds: List<ProductID>.from(map['productIds']),
      orderStatus: OrderStatus.fromStorageString(map['orderStatus']),
      orderDate: parseTimestamp(map['orderDate']),
      total: map['total']?.toDouble() ?? 0.0,
      // 決済関連フィールド
      paymentIntentId: map['paymentIntentId'],
      paymentMethodId: map['paymentMethodId'],
      paymentStatus:
          map['paymentStatus'] != null
              ? PaymentStatus.fromStorageString(map['paymentStatus'])
              : null,
      chargeId: map['chargeId'],
      receiptUrl: map['receiptUrl'],
      refundId: map['refundId'],
      paymentMetadata:
          map['paymentMetadata'] != null
              ? PaymentMetadata.fromMap(map['paymentMetadata'])
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderData.fromJson(String source) =>
      OrderData.fromMap(json.decode(source));
}

// class OrderWithProductTitles extends Order {
//   final Map<ProductID, String> productTitles;

//   OrderWithProductTitles({
//     required super.id,
//     required super.pickupId,
//     required super.items,
//     required super.productIds,
//     required super.orderStatus,
//     required super.orderDate,
//     required super.total,
//     required this.productTitles,
//   });

//   factory OrderWithProductTitles.fromMap(Map<String, dynamic> map) {
//     // タイムスタンプ変換用のヘルパー関数
//     DateTime parseTimestamp(dynamic timestamp) {
//       if (timestamp is int) {
//         // UNIXタイムスタンプ（ミリ秒）
//         return DateTime.fromMillisecondsSinceEpoch(timestamp);
//       } else if (timestamp is String) {
//         // ISO 8601形式の文字列
//         return DateTime.parse(timestamp);
//       } else {
//         // 不明なフォーマットの場合は現在時刻をデフォルトとする
//         return DateTime.now();
//       }
//     }

//     return OrderWithProductTitles(
//       id: map['id'],
//       pickupId: map['pickupId'],
//       items: Map<ProductID, int>.from(map['items']),
//       productIds: List<ProductID>.from(map['productIds']),
//       orderStatus: OrderStatus.fromStorageString(map['orderStatus']),
//       orderDate: parseTimestamp(map['orderDate']),
//       total: map['total']?.toDouble() ?? 0.0,
//       productTitles: Map<ProductID, String>.from(map['productTitles'] ?? {}),
//     );
//   }
// }
