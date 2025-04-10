import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_order_app/src/common_widgets/async_value_ui.dart';
import 'package:mobile_order_app/src/constants/app_color.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/features/cart/application/cart_notifier.dart';
import 'package:mobile_order_app/src/features/checkout/presentation/payment_button_controller.dart';
import 'package:mobile_order_app/src/features/order/application/current_orders_notifier.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';
import 'package:mobile_order_app/src/routing/app_router.dart';

class PaymentProcessingScreen extends ConsumerStatefulWidget {
  const PaymentProcessingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState
    extends ConsumerState<PaymentProcessingScreen> {
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    // 状態変数を設定して重複呼び出しを防止
    if (!_isProcessing) {
      _isProcessing = true;
      // 少し遅延させてマウント後に実行
      Future.microtask(() {
        // 画面表示後すぐに注文処理を開始（APIリクエストのみ実行）
        if (mounted) {
          ref.read(paymentButtonControllerProvider.notifier).pay();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 状態に基づいて画面遷移などのサイドエフェクトを実行
    ref.listen<AsyncValue<void>>(paymentButtonControllerProvider, (
      previous,
      current,
    ) async {
      if (previous?.isLoading == true && current is AsyncError) {
        // エラー発生時にダイアログを表示
        showOrderErrorDialog(context, current);
      } else if (current is AsyncData) {
        // 成功時は注文詳細画面へ遷移
        //TODO 不要であれば以下コメントのコードを消す。
        // 少し遅延を入れて状態更新が完了するのを待つ
        // await Future.delayed(const Duration(milliseconds: 300));
        // final orders = ref.read(currentOrdersNotifierProvider);
        // debugPrint('Orders after payment: ${orders.toString()}');
        // final newOrderId = orders.isNotEmpty ? orders.last.id : null;
        // コントローラーから直接注文IDを取得
        final newOrderId =
            ref.read(paymentButtonControllerProvider.notifier).orderId;

        debugPrint('直接取得した注文ID: $newOrderId');
        //addOrderが完了したら、カートを空にする。
        ref.read(cartNotifierProvider.notifier).resetCart();
        if (newOrderId != null) {
          context.goNamed(
            AppRoute.currentOrder.name,
            pathParameters: {'id': newOrderId},
          );
        } else {
          // IDがない場合は通常の注文画面に遷移
          context.goNamed(AppRoute.home.name);
        }
      }
    });

    // UI構築（基本的にはローディング表示）
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: mainColor),
              gapH16,
              Text(
                '注文を処理しています...'.hardcoded,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              gapH8,
              Text(
                'しばらくお待ちください'.hardcoded,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// エラーダイアログを表示する関数
void showOrderErrorDialog(BuildContext context, AsyncValue state) {
  final errorMessage = state.errorMessage;

  showDialog(
    context: context,
    barrierDismissible: false, // ダイアログ外をタップしても閉じないようにする
    builder:
        (context) => AlertDialog(
          icon: const Icon(Icons.error_outline, color: Colors.red, size: 48),
          title: Text('注文処理エラー'.hardcoded),
          content: SingleChildScrollView(
            child: Text(
              errorMessage.isNotEmpty
                  ? errorMessage
                  : '注文処理中にエラーが発生しました。もう一度お試しください。',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // ダイアログを閉じてからCheckout画面に戻る
                Navigator.of(context).pop();
                context.goNamed('checkout');
              },
              child: Text('注文画面に戻る'.hardcoded),
            ),
          ],
        ),
  );
}
