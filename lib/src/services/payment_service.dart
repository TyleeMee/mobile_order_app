import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mobile_order_app/src/models/payment_intent.dart';
import 'package:mobile_order_app/src/features/cart/domain/cart.dart';
import 'package:mobile_order_app/src/utils/cart_payment_converter.dart';
import 'package:mobile_order_app/src/services/stripe_api_client.dart';
import 'package:mobile_order_app/src/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_service.g.dart';

class PaymentService {
  // PaymentIntent作成（バックエンドAPI呼び出し）
  Future<PaymentIntentResponse> createPaymentIntent({
    required double amount,
    required String currency,
    String? customerId,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await StripeApiClient.createPaymentIntent(
        amount: amount,
        currency: currency,
        customerId: customerId,
        metadata: metadata,
      );

      return PaymentIntentResponse.fromMap(response);
    } catch (e) {
      debugPrint('PaymentIntent作成エラー: $e');
      rethrow;
    }
  }

  // 決済の全工程を実行
  Future<PaymentIntent> processPayment({required String clientSecret}) async {
    try {
      // Stripe決済画面を表示
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Mobile Order App',
          style: ThemeMode.system,
          billingDetails: const BillingDetails(
            // 必要に応じて事前入力
          ),
        ),
      );

      // PaymentSheetを表示
      await Stripe.instance.presentPaymentSheet();

      // 決済結果を取得
      final paymentIntent = await Stripe.instance.retrievePaymentIntent(
        clientSecret,
      );

      return paymentIntent;
    } on StripeException catch (e) {
      debugPrint('Stripe決済エラー: ${e.error.localizedMessage}');
      rethrow;
    } catch (e) {
      debugPrint('決済処理エラー: $e');
      rethrow;
    }
  }

  // カード情報保存用のSetupIntent作成
  Future<String> createSetupIntent({
    String? customerId,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await StripeApiClient.createSetupIntent(
        customerId: customerId,
        metadata: metadata,
      );

      final clientSecret = response['client_secret'] as String?;
      if (clientSecret == null || clientSecret.isEmpty) {
        throw Exception('SetupIntent作成に失敗しました: client_secretが取得できませんでした');
      }

      return clientSecret;
    } catch (e) {
      debugPrint('SetupIntent作成エラー: $e');
      rethrow;
    }
  }

  // カード登録の全工程を実行
  Future<void> processCardRegistration({
    required String setupIntentClientSecret,
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          setupIntentClientSecret: setupIntentClientSecret,
          merchantDisplayName: 'Mobile Order App',
          style: ThemeMode.system,
        ),
      );

      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      debugPrint('カード登録エラー: ${e.error.localizedMessage}');
      rethrow;
    }
  }

  // Cart情報からPaymentIntent作成
  Future<PaymentIntentResponse> createPaymentIntentFromCart({
    required Cart cart,
    required Future<Product?> Function(String productId) getProduct,
    String? customerId,
    String? orderId,
    String? userId,
  }) async {
    try {
      // カート商品情報を取得
      final products = await CartPaymentConverter.getCartProducts(
        cart: cart,
        getProduct: getProduct,
      );

      // 決済情報を生成
      final paymentInfo = CartPaymentConverter.toPaymentCartInfo(
        cart: cart,
        products: products,
      );

      // メタデータを生成
      final metadata = CartPaymentConverter.generatePaymentMetadata(
        cart: cart,
        products: products,
        orderId: orderId,
        userId: userId,
      );

      return await createPaymentIntent(
        amount: paymentInfo.total,
        currency: paymentInfo.currency,
        customerId: customerId,
        metadata: metadata,
      );
    } catch (e) {
      debugPrint('Cart決済Intent作成エラー: $e');
      rethrow;
    }
  }
}

@riverpod
PaymentService paymentService(Ref ref) {
  return PaymentService();
}
