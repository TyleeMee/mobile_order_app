import 'package:flutter/material.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  /// PrimaryButton を作成する。
  /// [isLoading] が true の場合、テキストの代わりにローディングインジケーターが表示される。
  const PrimaryButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onPressed,
  });
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      child: ElevatedButton(
        onPressed: onPressed,
        child:
            isLoading
                ? const CircularProgressIndicator()
                : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.white),
                ),
      ),
    );
  }
}
