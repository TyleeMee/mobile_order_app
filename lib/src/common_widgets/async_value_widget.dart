import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/common_widgets/async_value_ui.dart';
import 'package:mobile_order_app/src/common_widgets/error_message_widget.dart';
import 'package:mobile_order_app/src/common_widgets/reconnect_view.dart';

///AsyncValue を使用する際に、デフォルトのLoading widgetとError widgetを提供するWidget
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.error,
    this.retry = true,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final bool retry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error:
          (e, st) =>
              error != null
                  ? error!(e, st)
                  : retry
                  ? Center(child: ReconnectView())
                  : const SizedBox.shrink(), // リトライボタンがない場合は何も表示しない
      loading:
          () =>
              loading != null
                  ? loading!()
                  : Stack(
                    children: [
                      //TODOこのif文が部分が本当に必要か後ほど確認
                      // データ部分（ロード中でも表示）
                      if (value.hasValue) data(value.value as T),

                      // オーバーレイ（全画面に透過する灰色背景）
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withAlpha(77),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  ),
    );
  }
}
