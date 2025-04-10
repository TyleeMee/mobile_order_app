import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/common_widgets/reconnect_view.dart';

class MultiAsyncValueWidget extends StatelessWidget {
  const MultiAsyncValueWidget({
    super.key,
    required this.asyncValues,
    required this.data,
    this.loading,
    this.error,
    this.retry = true,
  });

  final List<AsyncValue> asyncValues;
  final Widget Function() data;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final bool retry;

  @override
  Widget build(BuildContext context) {
    // いずれかがローディング中
    if (asyncValues.any((value) => value.isLoading)) {
      return loading?.call() ??
          SizedBox(
            //画面全体の高さからAppBarとステータスバー（各デバイスの上部）を引いた高さ
            height:
                MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Container(
              width: double.infinity,
              color: Colors.black.withAlpha(77),
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
    }

    // いずれかがエラー
    final errorValue = asyncValues.firstWhere(
      (value) => value.hasError,
      orElse: () => AsyncValue.data(null),
    );

    if (errorValue.hasError) {
      if (error != null) {
        return error!(errorValue.error as Object, errorValue.stackTrace);
      }
      return retry ? Center(child: ReconnectView()) : const SizedBox.shrink();
    }

    // すべて正常
    return data();
  }
}
