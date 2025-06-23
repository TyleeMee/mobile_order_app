import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mobile_order_app/src/features/cart/application/cart_notifier.dart';
import 'package:mobile_order_app/src/features/checkout/application/checkout_service.dart';
import 'package:mobile_order_app/src/services/payment_service.dart';
import 'package:mobile_order_app/src/services/products_service.dart';
import 'package:mobile_order_app/src/utils/notifier_mounted.dart';
import 'package:mobile_order_app/src/utils/payment_error_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_button_controller.g.dart';

@riverpod
class PaymentButtonController extends _$PaymentButtonController
    with NotifierMounted {
  String? _orderId;
  String? _paymentIntentId;

  String? get orderId => _orderId;
  String? get paymentIntentId => _paymentIntentId;

  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
  }

  Future<void> pay() async {
    state = const AsyncLoading();

    try {
      // 1. カート情報を取得
      final cart = ref.read(cartNotifierProvider);

      if (cart.items.isEmpty) {
        throw Exception('カートが空です');
      }

      // 2. PaymentIntent作成（Cart変換ユーティリティ使用）
      final paymentService = ref.read(paymentServiceProvider);
      final paymentIntentResponse = await paymentService
          .createPaymentIntentFromCart(
            cart: cart,
            getProduct:
                (productId) => ref.read(productProvider(productId).future),
            // customerId: ownerIdがあればそれを使用
            // userId: ユーザーIDがあれば指定
          );

      _paymentIntentId = paymentIntentResponse.id;

      // 3. Stripe決済画面表示・決済実行
      final paymentIntent = await paymentService.processPayment(
        clientSecret: paymentIntentResponse.clientSecret,
      );

      // 4. 決済成功確認
      // 正しいステータスチェック方法
      if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        // 5. 決済成功後に注文作成
        final checkoutService = ref.read(checkoutServiceProvider);
        final order = await checkoutService.placeOrder(
          paymentIntentId: paymentIntentResponse.id,
        );

        _orderId = order?.id; // 注文IDを保存

        // * コントローラーがマウントされているか確認してから状態を設定すること。
        // * そうしないと、「dispose が呼ばれた後に PaymentButtonController を使おうとしました」という
        // * エラー（Bad state）が発生してしまう可能性がある。
        if (mounted) {
          state = const AsyncData(null);
        }
      } else {
        throw Exception('決済が完了しませんでした: ${paymentIntent.status}');
      }
    } on StripeException catch (e) {
      _handleStripeError(e);
    } catch (e) {
      _handleGenericError(e);
    }
  }

  // カード登録専用メソッド
  Future<void> registerCard(BuildContext context) async {
    state = const AsyncLoading();

    try {
      final paymentService = ref.read(paymentServiceProvider);

      // SetupIntent作成
      final setupIntentClientSecret = await paymentService.createSetupIntent();

      // カード登録画面表示
      await paymentService.processCardRegistration(
        setupIntentClientSecret: setupIntentClientSecret,
      );

      if (mounted) {
        state = const AsyncData(null);
      }
    } on StripeException catch (e) {
      _handleStripeError(e, isCardRegistration: true);
    } catch (e) {
      _handleGenericError(e, isCardRegistration: true);
    }
  }

  // Stripeエラーのハンドリング
  void _handleStripeError(
    StripeException e, {
    bool isCardRegistration = false,
  }) {
    // エラーメッセージを取得
    final errorMessage = PaymentErrorHandler.getErrorMessage(e);

    // デバッグ情報をログ出力
    debugPrint('${isCardRegistration ? 'カード登録' : '決済'}エラー詳細:');
    debugPrint(PaymentErrorHandler.getDebugInfo(e).toString());

    // 再試行可能かチェック
    final isRetryable = PaymentErrorHandler.isRetryable(e);
    debugPrint('再試行可能: $isRetryable');

    if (mounted) {
      state = AsyncError(
        _buildUserFriendlyMessage(
          errorMessage,
          isRetryable,
          isCardRegistration,
        ),
        StackTrace.current,
      );
    }
  }

  // 一般的なエラーのハンドリング
  void _handleGenericError(dynamic error, {bool isCardRegistration = false}) {
    final errorMessage =
        isCardRegistration
            ? 'カード登録中にエラーが発生しました: ${error.toString()}'
            : '決済処理中にエラーが発生しました: ${error.toString()}';

    debugPrint(errorMessage);

    if (mounted) {
      state = AsyncError(errorMessage, StackTrace.current);
    }
  }

  // ユーザー向けのわかりやすいエラーメッセージを構築
  String _buildUserFriendlyMessage(
    String errorMessage,
    bool isRetryable,
    bool isCardRegistration,
  ) {
    final baseMessage = errorMessage;

    if (isRetryable) {
      return '$baseMessage\n\nしばらく待ってから再度お試しください。';
    } else if (isCardRegistration) {
      return '$baseMessage\n\n別のカードをお試しいただくか、サポートにお問い合わせください。';
    } else {
      return '$baseMessage\n\n別の支払い方法をお試しいただくか、サポートにお問い合わせください。';
    }
  }

  // エラー状態をクリア
  void clearError() {
    if (mounted) {
      state = const AsyncData(null);
    }
  }

  // 再試行メソッド
  Future<void> retry(BuildContext context) async {
    await pay();
  }

  // カード登録の再試行メソッド
  Future<void> retryCardRegistration(BuildContext context) async {
    await registerCard(context);
  }
}
