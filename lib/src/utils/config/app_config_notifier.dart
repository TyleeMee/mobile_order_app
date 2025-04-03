import 'package:flutter/material.dart';
import 'package:mobile_order_app/src/utils/config/app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config_notifier.g.dart';

@Riverpod(keepAlive: true)
class AppConfigNotifier extends _$AppConfigNotifier {
  @override
  AppConfig build() {
    // 初期状態
    return const AppConfig(ownerId: '');
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

    // 状態を更新
    // state = newState;

    // 更新後の状態をログ出力
    debugPrint(
      '更新後: ownerId=${state.ownerId}, displayMode=${state.displayMode}',
    );

    return state;
  }
}
