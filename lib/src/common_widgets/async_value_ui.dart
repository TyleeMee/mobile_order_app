import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/common_widgets/alert_dialog.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';

/// A helper [AsyncValue] extension to show an alert dialog on error
/// and convert technical error messages to user-friendly ones
extension AsyncValueUI on AsyncValue {
  /// show an alert dialog if the current [AsyncValue] has an error and the
  /// state is not loading.
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      final message = errorMessage;
      showExceptionAlertDialog(
        context: context,
        title: 'エラー'.hardcoded,
        exception: message,
      );
    }
  }

  /// Get a user-friendly error message from the current error
  String get errorMessage => _errorMessage(error);

  /// Get a user-friendly error message for different error types
  static String _errorMessage(Object? error) {
    //TODO アプリ固有の例外を追加する
    // if (error is AppException) {
    //   return error.message;
    // } else {
    return _userFriendlyError(error);
    // }
  }

  /// Convert technical error messages to user-friendly ones
  static String _userFriendlyError(Object? error) {
    if (error == null) return 'エラーが発生しました。'.hardcoded;

    final errorString = error.toString();
    //TODO デバッグ不要になったら以下の1文を削除
    return 'デバッグエラー:$errorString';

    // Network related errors
    if (errorString.contains('SocketException') ||
        errorString.contains('HttpException')) {
      return 'ネットワーク接続に問題があります。接続を確認してください。'.hardcoded;
    }

    // Timeout errors
    if (errorString.contains('TimeoutException')) {
      return 'サーバーからの応答がありません。後でもう一度お試しください。'.hardcoded;
    }

    //TODO 認証不要であれば削除する。
    // 認証エラー
    // if (errorString.contains('Authentication') ||
    //     errorString.contains('401') ||
    //     errorString.contains('403')) {
    //   return '認証に失敗しました。再度ログインしてください。'.hardcoded;
    // }

    //特定のユーザーフレンドリーなメッセージがない場合は、汎用的なメッセージを返す。
    // print('Original error: $errorString');
    return 'エラーが発生しました。後でもう一度お試しください。'.hardcoded;
  }
}
