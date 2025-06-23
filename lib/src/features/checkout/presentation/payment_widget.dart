import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:mobile_order_app/src/features/checkout/presentation/payment_button_controller.dart';
import 'package:mobile_order_app/src/utils/payment_error_handler.dart';

class PaymentWidget extends ConsumerWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentState = ref.watch(paymentButtonControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 決済ボタン
        _buildPaymentButton(context, ref, paymentState),

        const SizedBox(height: 16),

        // カード登録ボタン
        _buildCardRegistrationButton(context, ref, paymentState),

        const SizedBox(height: 16),

        // エラー表示エリア
        _buildErrorDisplay(context, ref, paymentState),

        // 成功表示エリア
        _buildSuccessDisplay(context, ref, paymentState),
      ],
    );
  }

  // 決済ボタンの構築
  Widget _buildPaymentButton(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<void> paymentState,
  ) {
    return ElevatedButton(
      onPressed:
          paymentState.isLoading ? null : () => _handlePayment(context, ref),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      child:
          paymentState.isLoading
              ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
              : const Text(
                '決済する',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
    );
  }

  // カード登録ボタンの構築
  Widget _buildCardRegistrationButton(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<void> paymentState,
  ) {
    return OutlinedButton(
      onPressed:
          paymentState.isLoading
              ? null
              : () => _handleCardRegistration(context, ref),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: const BorderSide(color: Colors.blue),
      ),
      child: const Text('カードを登録', style: TextStyle(fontSize: 16)),
    );
  }

  // エラー表示エリアの構築
  Widget _buildErrorDisplay(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<void> paymentState,
  ) {
    return paymentState.when(
      data: (_) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
      error: (error, _) => _buildErrorCard(context, ref, error),
    );
  }

  // 成功表示エリアの構築
  Widget _buildSuccessDisplay(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<void> paymentState,
  ) {
    final controller = ref.watch(paymentButtonControllerProvider.notifier);

    return paymentState.when(
      data: (_) {
        // 注文IDがある場合は成功表示
        if (controller.orderId != null) {
          return _buildSuccessCard(context, controller.orderId!);
        }
        return const SizedBox.shrink();
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  // エラーカードの構築
  Widget _buildErrorCard(BuildContext context, WidgetRef ref, Object error) {
    final controller = ref.watch(paymentButtonControllerProvider.notifier);
    final errorMessage = error.toString();

    // Stripeエラーかどうかを判定してアクションボタンを表示
    final showRetryButton = _shouldShowRetryButton(error);

    return Card(
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.error, color: Colors.red.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'エラーが発生しました',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(errorMessage, style: TextStyle(color: Colors.red.shade700)),
            if (showRetryButton) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => controller.clearError(),
                    child: const Text('閉じる'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => controller.retry(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('再試行'),
                  ),
                ],
              ),
            ] else ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => controller.clearError(),
                  child: const Text('閉じる'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // 成功カードの構築
  Widget _buildSuccessCard(BuildContext context, String orderId) {
    return Card(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade700),
                const SizedBox(width: 8),
                Text(
                  '決済が完了しました',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '注文ID: $orderId',
              style: TextStyle(color: Colors.green.shade700),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _navigateToOrderDetails(context, orderId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                ),
                child: const Text('注文詳細を見る'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 決済処理のハンドリング
  Future<void> _handlePayment(BuildContext context, WidgetRef ref) async {
    try {
      final controller = ref.read(paymentButtonControllerProvider.notifier);
      await controller.pay();
    } catch (e) {
      // エラーは既にコントローラー内でハンドリングされているため、
      // ここでは追加の処理は不要
      debugPrint('決済処理でエラーが発生: $e');
    }
  }

  // カード登録処理のハンドリング
  Future<void> _handleCardRegistration(
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      final controller = ref.read(paymentButtonControllerProvider.notifier);
      await controller.registerCard(context);

      // 成功時にスナックバーを表示
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('カードの登録が完了しました'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // エラーは既にコントローラー内でハンドリングされているため、
      // ここでは追加の処理は不要
      debugPrint('カード登録処理でエラーが発生: $e');
    }
  }

  // 再試行ボタンを表示するかどうかの判定
  bool _shouldShowRetryButton(Object error) {
    // エラーメッセージに「再度お試し」が含まれている場合は再試行可能
    return error.toString().contains('再度お試し');
  }

  // 注文詳細画面への遷移
  void _navigateToOrderDetails(BuildContext context, String orderId) {
    // 実際のアプリでは注文詳細画面に遷移
    // Navigator.pushNamed(context, '/order-details', arguments: orderId);

    // デモ用のダイアログ表示
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('注文詳細'),
            content: Text('注文ID: $orderId\n\n注文詳細画面への遷移機能は実装中です。'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('閉じる'),
              ),
            ],
          ),
    );
  }
}
