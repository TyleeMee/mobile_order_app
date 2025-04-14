import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/firebase_options.dart';
import 'package:mobile_order_app/src/app.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:mobile_order_app/src/utils/web_url_strategy.dart';

//TODO デプロイ後にcors.jsonファイルの"https://your-app-name.web.app"を実際のURLに変更 "*"は本番環境では消す。
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // URLからパラメータを取得
  Uri url;
  if (kIsWeb) {
    url = UrlHelper.getCurrentUrl();
  } else {
    final defaultRoute =
        WidgetsBinding.instance.platformDispatcher.defaultRouteName;
    url = Uri.parse(defaultRoute);
  }
  // final defaultRoute =
  //     WidgetsBinding.instance.platformDispatcher.defaultRouteName;
  // final uri = Uri.parse(defaultRoute);
  // TODO mobile-order-manager（webApp）のプレビューからアクセスする際には、以下の1文をアンコメントし、2文目をコメントアウト
  final ownerId = url.queryParameters['ownerId'] ?? '';
  // final ownerId = 'mSnjBmpxQMMTEHTkvg3zk5gbWjt2';
  final displayMode = url.queryParameters['mode'] ?? 'normal';

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
