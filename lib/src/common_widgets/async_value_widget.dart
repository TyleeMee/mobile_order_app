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
                  : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      width: double.infinity,
                      color: Colors.black.withAlpha(77),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
    );
  }
}
