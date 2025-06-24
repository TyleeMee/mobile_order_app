import 'package:mobile_order_app/src/features/checkout/application/checkout_service.dart';
import 'package:mobile_order_app/src/utils/notifier_mounted.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_button_controller.g.dart';

@riverpod
class PaymentButtonController extends _$PaymentButtonController
    with NotifierMounted {
  String? _orderId;

  String? get orderId => _orderId;

  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
  }

  Future<void> pay() async {
    state = const AsyncLoading();
    final checkoutService = ref.read(checkoutServiceProvider);
    // 少し遅延させてUIの更新を確実にする
    await Future.delayed(const Duration(milliseconds: 50));

    try {
      final order = await checkoutService.placeOrder();
      _orderId = order?.id; // 注文IDを保存
      // * コントローラーがマウントされているか確認してから状態を設定すること。
      // * そうしないと、「dispose が呼ばれた後に PaymentButtonController を使おうとしました」という
      // * エラー（Bad state）が発生してしまう可能性がある。
      if (mounted) {
        state = const AsyncData(null);
      }
    } catch (e) {
      if (mounted) {
        state = AsyncError(e, StackTrace.current);
      }
    }
  }
}
