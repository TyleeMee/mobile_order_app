// src/services/stripe_api_client.dart
import 'package:flutter/material.dart';
import 'package:mobile_order_app/src/services/api_client.dart';

/// Stripe決済専用のAPIクライアント
/// 決済関連の処理のみを扱う
class StripeApiClient {
  // ============================================================================
  // PaymentIntent関連
  // ============================================================================

  /// PaymentIntent作成
  static Future<Map<String, dynamic>> createPaymentIntent({
    required double amount,
    required String currency,
    String? customerId,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await ApiClient.fetch(
        '/api/payment/create-intent',
        method: 'POST',
        body: {
          'amount': (amount * 100).round(), // Stripeは最小単位（セント）で処理
          'currency': currency,
          if (customerId != null) 'customer_id': customerId,
          if (metadata != null) 'metadata': metadata,
        },
      );

      if (response == null) {
        throw Exception('PaymentIntent作成のレスポンスが空です');
      }

      return Map<String, dynamic>.from(response);
    } catch (e) {
      debugPrint('PaymentIntent作成エラー: $e');
      rethrow;
    }
  }

  /// PaymentIntent詳細取得
  static Future<Map<String, dynamic>?> getPaymentIntent(
    String paymentIntentId,
  ) async {
    try {
      final response = await ApiClient.fetch(
        '/api/payment/intent/$paymentIntentId',
      );
      return response != null ? Map<String, dynamic>.from(response) : null;
    } catch (e) {
      debugPrint('PaymentIntent取得エラー: $e');
      rethrow;
    }
  }

  /// PaymentIntent確認
  static Future<Map<String, dynamic>?> confirmPayment({
    required String paymentIntentId,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await ApiClient.fetch(
        '/api/payment/confirm',
        method: 'POST',
        body: {
          'payment_intent_id': paymentIntentId,
          if (metadata != null) 'metadata': metadata,
        },
      );
      return response != null ? Map<String, dynamic>.from(response) : null;
    } catch (e) {
      debugPrint('PaymentIntent確認エラー: $e');
      rethrow;
    }
  }

  // ============================================================================
  // SetupIntent関連（カード登録用）
  // ============================================================================

  /// SetupIntent作成（カード登録用）
  static Future<Map<String, dynamic>> createSetupIntent({
    String? customerId,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await ApiClient.fetch(
        '/api/payment/create-setup-intent',
        method: 'POST',
        body: {
          if (customerId != null) 'customer_id': customerId,
          if (metadata != null) 'metadata': metadata,
        },
      );

      if (response == null) {
        throw Exception('SetupIntent作成のレスポンスが空です');
      }

      return Map<String, dynamic>.from(response);
    } catch (e) {
      debugPrint('SetupIntent作成エラー: $e');
      rethrow;
    }
  }

  // ============================================================================
  // Customer関連
  // ============================================================================

  /// Stripe Customer作成
  static Future<Map<String, dynamic>> createCustomer({
    required String email,
    String? name,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await ApiClient.fetch(
        '/api/payment/create-customer',
        method: 'POST',
        body: {
          'email': email,
          if (name != null) 'name': name,
          if (metadata != null) 'metadata': metadata,
        },
      );

      if (response == null) {
        throw Exception('Customer作成のレスポンスが空です');
      }

      return Map<String, dynamic>.from(response);
    } catch (e) {
      debugPrint('Customer作成エラー: $e');
      rethrow;
    }
  }

  /// Customer情報取得
  static Future<Map<String, dynamic>?> getCustomer(String customerId) async {
    try {
      final response = await ApiClient.fetch(
        '/api/payment/customer/$customerId',
      );
      return response != null ? Map<String, dynamic>.from(response) : null;
    } catch (e) {
      debugPrint('Customer取得エラー: $e');
      rethrow;
    }
  }

  // ============================================================================
  // PaymentMethod関連
  // ============================================================================

  /// 保存された決済方法を取得
  static Future<List<Map<String, dynamic>>> getPaymentMethods(
    String customerId,
  ) async {
    try {
      final response = await ApiClient.fetch(
        '/api/payment/customer/$customerId/payment-methods',
      );

      if (response == null) {
        return [];
      }

      if (response is List) {
        return response.map((item) => Map<String, dynamic>.from(item)).toList();
      } else if (response is Map && response['data'] is List) {
        // Stripeのレスポンス形式に対応
        return (response['data'] as List)
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      }

      return [];
    } catch (e) {
      debugPrint('PaymentMethods取得エラー: $e');
      rethrow;
    }
  }

  /// 決済方法を削除
  static Future<bool> detachPaymentMethod(String paymentMethodId) async {
    try {
      final response = await ApiClient.fetch(
        '/api/payment/payment-method/$paymentMethodId/detach',
        method: 'POST',
      );
      return response != null;
    } catch (e) {
      debugPrint('PaymentMethod削除エラー: $e');
      return false;
    }
  }

  // ============================================================================
  // Refund関連
  // ============================================================================

  /// 返金処理
  static Future<Map<String, dynamic>?> createRefund({
    required String paymentIntentId,
    double? amount,
    String? reason,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await ApiClient.fetch(
        '/api/payment/refund',
        method: 'POST',
        body: {
          'payment_intent_id': paymentIntentId,
          if (amount != null) 'amount': (amount * 100).round(),
          if (reason != null) 'reason': reason,
          if (metadata != null) 'metadata': metadata,
        },
      );
      return response != null ? Map<String, dynamic>.from(response) : null;
    } catch (e) {
      debugPrint('返金処理エラー: $e');
      rethrow;
    }
  }

  // ============================================================================
  // Webhook関連（将来的に使用）
  // ============================================================================

  /// Webhook処理
  static Future<Map<String, dynamic>?> handleWebhook({
    required String eventType,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await ApiClient.fetch(
        '/api/payment/webhook',
        method: 'POST',
        body: {'event_type': eventType, 'data': data},
      );
      return response != null ? Map<String, dynamic>.from(response) : null;
    } catch (e) {
      debugPrint('Webhook処理エラー: $e');
      rethrow;
    }
  }
}
