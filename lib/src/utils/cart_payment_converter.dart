// src/utils/cart_payment_converter.dart
import 'package:mobile_order_app/src/features/cart/domain/cart.dart';
import 'package:mobile_order_app/src/models/payment_intent.dart';
import 'package:mobile_order_app/src/models/product.dart';

/// 既存のCartを決済用の情報に変換するユーティリティクラス
class CartPaymentConverter {
  /// CartをPaymentCartInfoに変換
  static PaymentCartInfo toPaymentCartInfo({
    required Cart cart,
    required Map<ProductID, Product> products,
  }) {
    double total = 0.0;
    int itemCount = 0;
    List<String> productNames = [];

    // カート内の各アイテムについて計算
    for (final entry in cart.items.entries) {
      final productId = entry.key;
      final quantity = entry.value;
      final product = products[productId];

      if (product != null) {
        total += product.price * quantity;
        itemCount += quantity;
        productNames.add(product.title);
      }
    }

    // 説明文を生成
    String description = '';
    if (productNames.isNotEmpty) {
      if (productNames.length <= 3) {
        description = productNames.join(', ');
      } else {
        description =
            '${productNames.take(2).join(', ')} 他${productNames.length - 2}品';
      }
    }

    return PaymentCartInfo(
      total: total,
      currency: 'jpy',
      itemCount: itemCount,
      description: description.isNotEmpty ? description : '注文商品',
    );
  }

  /// カートの合計金額を計算（シンプル版）
  static Future<double> calculateCartTotal({
    required Cart cart,
    required Future<Product?> Function(String productId) getProduct,
  }) async {
    double total = 0.0;

    for (final entry in cart.items.entries) {
      final productId = entry.key;
      final quantity = entry.value;
      final product = await getProduct(productId);

      if (product != null) {
        total += product.price * quantity;
      }
    }

    return total;
  }

  /// カートの商品情報を取得
  static Future<Map<ProductID, Product>> getCartProducts({
    required Cart cart,
    required Future<Product?> Function(String productId) getProduct,
  }) async {
    final Map<ProductID, Product> products = {};

    for (final productId in cart.items.keys) {
      final product = await getProduct(productId);
      if (product != null) {
        products[productId] = product;
      }
    }

    return products;
  }

  /// 決済用メタデータを生成
  static Map<String, dynamic> generatePaymentMetadata({
    required Cart cart,
    required Map<ProductID, Product> products,
    String? orderId,
    String? userId,
  }) {
    final metadata = <String, dynamic>{};

    // 基本情報
    metadata['item_count'] = cart.items.values.fold<int>(
      0,
      (sum, qty) => sum + qty,
    );
    metadata['product_count'] = cart.items.length;

    // 注文情報
    if (orderId != null) metadata['order_id'] = orderId;
    if (userId != null) metadata['user_id'] = userId;

    // 商品情報（最初の3つまで）
    final productNames =
        cart.items.keys
            .take(3)
            .map((id) => products[id]?.title ?? 'Unknown')
            .toList();

    for (int i = 0; i < productNames.length; i++) {
      metadata['product_${i + 1}'] = productNames[i];
    }

    return metadata;
  }

  /// 注文確認用の商品詳細を生成
  static List<Map<String, dynamic>> generateOrderDetails({
    required Cart cart,
    required Map<ProductID, Product> products,
  }) {
    return cart.items.entries.map((entry) {
      final productId = entry.key;
      final quantity = entry.value;
      final product = products[productId];

      return {
        'product_id': productId,
        'title': product?.title ?? 'Unknown Product',
        'price': product?.price ?? 0.0,
        'quantity': quantity,
        'subtotal': (product?.price ?? 0.0) * quantity,
      };
    }).toList();
  }
}
