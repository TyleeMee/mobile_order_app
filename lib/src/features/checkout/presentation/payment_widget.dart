import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_order_app/src/common_widgets/primary_button.dart';
import 'package:mobile_order_app/src/constants/app_color.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/features/cart/domain/cart.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';
import 'package:mobile_order_app/src/routing/app_router.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key, required this.cart});
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backGroundColorLightGrey,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'サービス利用規約'.hardcoded,
                      style: const TextStyle(color: accentColor),
                    ),
                    Text('、'.hardcoded),
                    Text(
                      'プライバシーポリシー'.hardcoded,
                      style: const TextStyle(color: accentColor),
                    ),
                  ],
                ),
                Text('に同意のうえ、先に進んでください。'.hardcoded),
              ],
            ),
            gapH16,
            PrimaryButton(
              text: '注文を確定する',
              // 注文確定ボタンが押されたら処理中画面に遷移
              onPressed:
                  cart.items.isNotEmpty
                      ? () async {
                        //*ボタンの押下アニメーション（リップルエフェクトなど）が開始される
                        //*同時にpushReplacementNamedが呼び出され、現在の画面を処理中画面に置き換えようとする
                        //*ボタンのアニメーションが終わってから、画面遷移するためにDurationを設ける
                        await Future.delayed(const Duration(milliseconds: 50));
                        // async操作後にmountedチェック
                        if (!context.mounted) return;
                        // replaceを使って現在の画面を置き換え、戻れないようにする
                        context.pushReplacementNamed(AppRoute.processing.name);
                      }
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
