import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:mobile_order_app/src/features/categories/domain/category.dart';
import 'package:mobile_order_app/src/features/order/domain/order.dart';
import 'package:mobile_order_app/src/features/products/domain/product.dart';
import 'package:mobile_order_app/src/features/shop/domain/shop.dart';

/// Firestoreの変換処理に関するユーティリティクラス
class FirestoreConverters {
  static DateTime _convertTimestamp(dynamic timestamp) {
    final now = DateTime.now();

    if (timestamp is fs.Timestamp) {
      return timestamp.toDate();
    } else if (timestamp is int) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    } else {
      return now;
    }
  }

  /// Productに変換
  static Product toProduct(String docId, Map<String, dynamic> docData) {
    return Product(
      id: docId,
      categoryId: docData['categoryId'] as CategoryID,
      title: docData['title'] ?? '',
      imageUrl: docData['imageUrl'] ?? '',
      imagePath: docData['imagePath'] ?? '',
      description: docData['description'],
      price: docData['price']?.toDouble() ?? 0.0,
      isVisible: docData['isVisible'] ?? false,
      isOrderAccepting: docData['isOrderAccepting'] ?? false,
      created: _convertTimestamp(docData['created']),
      updated: _convertTimestamp(docData['updated']),
    );
  }

  /// Categoryに変換
  static Category toCategory(String docId, Map<String, dynamic> docData) {
    return Category(
      id: docId,
      title: docData['title'] ?? '',
      created: _convertTimestamp(docData['created']),
      updated: _convertTimestamp(docData['updated']),
    );
  }

  /// Shopに変換
  static Shop toShop(String docId, Map<String, dynamic> docData) {
    return Shop(
      id: docId,
      title: docData['title'] ?? '',
      imageUrl: docData['imageUrl'] ?? '',
      imagePath: docData['imagePath'] ?? '',
      description: docData['description'],
      prefecture: Prefecture.fromDisplayName(docData['prefecture'] ?? '東京都'),
      city: docData['city'] ?? '',
      streetAddress: docData['streetAddress'] ?? '',
      building: docData['building'],
      isVisible: docData['isVisible'] ?? false,
      isOrderAccepting: docData['isOrderAccepting'] ?? false,
      created: _convertTimestamp(docData['created']),
      updated: _convertTimestamp(docData['updated']),
    );
  }

  /// Orderに変換
  static Order toOrder(String docId, Map<String, dynamic> docData) {
    return Order(
      id: docId,
      pickupId: docData['pickupId'] ?? '',
      items: _toItemsMap(docData['items']),
      productIds: _toProductIdsList(docData['productIds']),
      orderStatus: OrderStatus.fromStorageString(docData['orderStatus']),
      orderDate: _convertTimestamp(docData['orderDate']),
      total: docData['total']?.toDouble() ?? 0.0,
    );
  }

  /// `dynamic値から Map<ProductID, int> (items) に変換する`
  static Map<ProductID, int> _toItemsMap(
    dynamic value, {
    Map<ProductID, int> defaultValue = const {},
  }) {
    if (value == null) return defaultValue;

    // Firestoreから取得した値がMapであることを確認
    if (value is Map) {
      final result = <String, int>{};

      // 各エントリをStringキーとint値に変換
      value.forEach((k, v) {
        if (k is String) {
          if (v is int) {
            result[k] = v;
          } else if (v is num) {
            // numからintへ変換
            result[k] = v.toInt();
          }
        }
      });

      return result;
    }

    return defaultValue;
  }

  /// `dynamic値から List<ProductID> に変換する`
  static List<ProductID> _toProductIdsList(
    dynamic value, {
    List<ProductID> defaultValue = const [],
  }) {
    if (value == null) return defaultValue;

    // Firestoreの List 型は実際には List<dynamic> として扱われるため、明示的な型変換が必要
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }

    return defaultValue;
  }

  /// `Map<String, dynamic>から特定のキーに対応するList<String>を抽出する`
  ///
  /// [data] - Firestoreから取得したデータ
  /// [key] - 抽出したいリストのキー
  /// [defaultValue] - データが存在しない場合のデフォルト値（省略可）
  static List<String> toStringList(
    Map<String, dynamic>? data,
    String key, {
    List<String> defaultValue = const [],
  }) {
    if (data == null || !data.containsKey(key)) return defaultValue;

    final value = data[key];
    if (value == null) return defaultValue;

    //* Firestoreの List 型は実際には List<dynamic> として扱われるため、明示的な型変換が必要
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }

    return defaultValue;
  }
}
