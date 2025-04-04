import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/utils/config/app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config_notifier.g.dart';

@Riverpod(keepAlive: true)
class AppConfigNotifier extends _$AppConfigNotifier {
  @override
  AppConfig build() {
    // 初期状態 - ownerIdはnull
    return const AppConfig();
  }

  // 設定情報を更新
  AppConfig updateConfig({
    String? ownerId,
    String? displayMode,
    bool? isPreviewMode,
  }) {
    // 更新前の状態をログ出力
    debugPrint(
      '更新前: ownerId=${state.ownerId}, displayMode=${state.displayMode}',
    );

    // 新しい状態を作成
    state = state.copyWith(
      ownerId: ownerId ?? state.ownerId,
      displayMode: displayMode ?? state.displayMode,
      isPreviewMode: isPreviewMode ?? state.isPreviewMode,
    );

    // 更新後の状態をログ出力
    debugPrint(
      '更新後: ownerId=${state.ownerId}, displayMode=${state.displayMode}',
    );

    return state;
  }

  // 有効なownerIdが設定されるまで待機する関数
  Future<String> waitForValidOwnerId() async {
    // すでに有効なownerIdがある場合はそれを返す
    if (state.ownerId != null && state.ownerId!.isNotEmpty) {
      debugPrint('有効なownerIdがあります: ${state.ownerId}');
      return state.ownerId!;
    }

    // 有効なownerIdが設定されるまで待機
    debugPrint('有効なownerIdを待っています...');

    // 最大3秒間、ポーリングしてownerIdが設定されるのを待つ
    for (int i = 0; i < 30; i++) {
      await Future.delayed(const Duration(milliseconds: 100));

      if (state.ownerId != null && state.ownerId!.isNotEmpty) {
        debugPrint('有効なownerIdが設定されました: ${state.ownerId}');
        return state.ownerId!;
      }
    }

    // タイムアウトした場合はエラーをスロー
    throw Exception('ownerIdの初期化タイムアウト: 有効なownerIdが設定されませんでした');
  }
}

// 有効なownerIdを取得するための便利なプロバイダー
@riverpod
Future<String> validOwnerId(Ref ref) {
  final appConfigNotifier = ref.watch(appConfigNotifierProvider.notifier);
  return appConfigNotifier.waitForValidOwnerId();
}
