import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/common_widgets/alert_dialog.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';

/// エラー時にアラートダイアログを表示し、
/// 技術的なエラーメッセージをユーザーにわかりやすいものに変換するための
/// [AsyncValue] 拡張のヘルパー
extension AsyncValueUI on AsyncValue {
  /// 現在の [AsyncValue] にエラーがあり、
  /// かつ状態がローディング中でない場合にアラートダイアログを表示する。
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

  /// 現在のエラーから、ユーザーフレンドリーなエラーメッセージを取得する
  String get errorMessage => _errorMessage(error);

  /// さまざまなエラータイプに対して、ユーザーフレンドリーなエラーメッセージを取得する
  static String _errorMessage(Object? error) {
    //TODO アプリ固有の例外を追加する
    // if (error is AppException) {
    //   return error.message;
    // } else {
    return _userFriendlyError(error);
    // }
  }

  /// 技術的なエラーメッセージをユーザーフレンドリーなものに変換する
  static String _userFriendlyError(Object? error) {
    if (error == null) return 'エラーが発生しました。'.hardcoded;

    final errorString = error.toString();

    // ネットワーク関連エラー
    if (errorString.contains('SocketException') ||
        errorString.contains('HttpException')) {
      return 'ネットワーク接続に問題があります。接続を確認してください。'.hardcoded;
    }

    // タイムアウトエラー
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
    return 'エラーが発生しました。後でもう一度お試しください。'.hardcoded;
  }
}
