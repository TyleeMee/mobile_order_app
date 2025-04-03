import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_order_app/firebase_options.dart';
import 'package:mobile_order_app/src/common_widgets/alert_dialog.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';

class ReconnectView extends StatefulWidget {
  const ReconnectView({
    super.key,
    this.onPressed,
    this.message = 'インターネット接続がありません',
  });
  final VoidCallback? onPressed;
  final String message;

  @override
  State<ReconnectView> createState() => _ReconnectViewState();
}

class _ReconnectViewState extends State<ReconnectView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.amber.shade100,
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.wifi_off, color: Colors.amber.shade900),
              const SizedBox(width: 8.0),
              Text('オフライン状態です', style: TextStyle(color: Colors.amber.shade900)),
            ],
          ),
        ),
        // 中央にメッセージと再接続ボタンを配置
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_off, size: 64.0, color: Colors.grey),
                const SizedBox(height: 24.0),
                Text(
                  widget.message,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                const Text('一部の機能が制限されています。', textAlign: TextAlign.center),
                //
                // const Text(
                //   '接続が回復次第、最新情報に更新されます。',
                //   textAlign: TextAlign.center,
                // ),
                const SizedBox(height: 32.0),
                ElevatedButton.icon(
                  // 再接続ボタンのonPressedハンドラ内
                  onPressed: _handleReconnect,
                  icon: const Icon(Icons.refresh),
                  label: const Text('再接続する'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //TODO 再接続処理、およびそのLoadingstateを設定する。
  // 再接続処理を別メソッドに分離
  Future<void> _handleReconnect() async {
    // 非同期処理の前にコンテキスト関連の状態を取得
    final currentLocation = GoRouterState.of(context).matchedLocation;

    // オーバーレイ用のOverlayEntry作成
    final overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              // オーバーレイ（全画面に透過する灰色背景）
              Positioned.fill(
                child: Container(
                  color: Colors.black.withAlpha(77),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
    );

    // オーバーレイを表示
    overlayState.insert(overlayEntry);

    // 接続を試みる
    bool isConnected = false;
    try {
      isConnected = await checkConnectionAndReconnect();
    } finally {
      // オーバーレイを削除（エラーが発生した場合でも確実に削除）
      overlayEntry.remove();
    }

    // mounted プロパティを使用して、ウィジェットがまだ画面に表示されているか確認
    if (!mounted) return;

    if (isConnected) {
      // 接続成功時: 現在のルートを再読み込み
      context.go(currentLocation, extra: {'reload': true});
    } else {
      // 接続失敗時: アラートダイアログを表示
      if (mounted) {
        showAlertDialog(
          context: context,
          title: '接続に失敗しました。後でもう一度お試しください。'.hardcoded,
        );
      }
    }

    //TODO 不要であれば消す。
    // 元のonPressedコールバックも呼び出す
    // widget.onPressed();
  }
}

// 接続状態の確認と再接続処理の例
Future<bool> checkConnectionAndReconnect() async {
  // ネットワーク状態の確認
  // Firebase接続の再試行
  // 成功したらtrueを返す
  try {
    // 接続試行のロジック
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return true;
  } catch (e) {
    debugPrint('接続エラー: $e');
    return false;
  }
}
