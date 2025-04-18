import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:mobile_order_app/firebase_options.dart';
import 'package:mobile_order_app/src/app.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:mobile_order_app/src/utils/web_url_strategy.dart';

// ロガーのインスタンスを作成
final logger = Logger(
  level: kReleaseMode ? Level.info : Level.debug, // リリースモードではinfoレベル以上のみ
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 80,
    colors: !kReleaseMode, // リリースモードでは色を無効化
    printEmojis: !kReleaseMode, // リリースモードでは絵文字を無効化
  ),
);

//TODO デプロイ後にcors.jsonファイルの"https://your-app-name.web.app"を実際のURLに変更 "*"は本番環境では消す。
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  String ownerId = '';
  String displayMode = 'normal';

  // Webプラットフォームの場合
  //* flutter web用のURLパラメータの取得
  if (kIsWeb) {
    try {
      // 新しい方法でURLを取得
      final currentUrl = UrlHelper.getCurrentUrl();
      ownerId = currentUrl.queryParameters['ownerId'] ?? '';
      displayMode = currentUrl.queryParameters['mode'] ?? 'normal';

      // デバッグ情報
      logger.d('Web URL: ${currentUrl.toString()}');
      logger.d('Query params: ${currentUrl.queryParameters}');
    } catch (e) {
      logger.e('URL解析エラー: $e');
      // フォールバック
      ownerId = 'mSnjBmpxQMMTEHTkvg3zk5gbWjt2';
    }
  } else {
    // 非Webプラットフォームの場合（元の方法）
    final defaultRoute =
        WidgetsBinding.instance.platformDispatcher.defaultRouteName;
    final uri = Uri.parse(defaultRoute);
    ownerId = uri.queryParameters['ownerId'] ?? '';
    displayMode = uri.queryParameters['mode'] ?? 'normal';
  }

  // ownerIdが空の場合はデフォルト値を使用
  if (ownerId.isEmpty) {
    ownerId = 'mSnjBmpxQMMTEHTkvg3zk5gbWjt2';
  }

  logger.i('最終的なownerId: $ownerId');
  logger.i('displayMode: $displayMode');

  runApp(
    ProviderScope(
      overrides: [
        // 最新の推奨される方法で、Providerをオーバーライドする
        appConfigNotifierProvider.overrideWith(() {
          final notifier = AppConfigNotifier();
          // フレーム描画後に設定を更新
          WidgetsBinding.instance.addPostFrameCallback((_) {
            notifier.updateConfig(ownerId: ownerId, displayMode: displayMode);
          });
          return notifier;
        }),
      ],
      child: MyApp(),
    ),
  );
}
