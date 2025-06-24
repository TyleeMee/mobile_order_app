import 'package:flutter_stripe/flutter_stripe.dart';

/// 決済エラーハンドリングユーティリティ
class PaymentErrorHandler {
  /// Stripe例外を分析して適切なエラーメッセージを返す
  static String getErrorMessage(StripeException exception) {
    final error = exception.error;

    // FailureCodeで分岐（正しい定数名を使用）
    switch (error.code) {
      case FailureCode.Failed:
        return _getFailedMessage(error);

      case FailureCode.Canceled:
        return '決済がキャンセルされました。';

      case FailureCode.Timeout:
        return '決済がタイムアウトしました。再度お試しください。';

      default:
        return error.localizedMessage ?? '不明なエラーが発生しました。';
    }
  }

  /// カード拒否の詳細メッセージ
  static String _getCardDeclinedMessage(String? declineCode) {
    switch (declineCode) {
      case 'insufficient_funds':
        return 'カードの残高が不足しています。';
      case 'expired_card':
        return 'カードの有効期限が切れています。';
      case 'incorrect_cvc':
        return 'セキュリティコードが正しくありません。';
      case 'processing_error':
        return 'カード処理エラーが発生しました。';
      case 'incorrect_number':
        return 'カード番号が正しくありません。';
      default:
        return 'カードが拒否されました。別のカードをお試しください。';
    }
  }

  /// 失敗エラーの詳細メッセージ
  static String _getFailedMessage(LocalizedErrorMessage error) {
    // stripeErrorCodeがある場合はそれを使用
    if (error.stripeErrorCode != null) {
      switch (error.stripeErrorCode) {
        case 'payment_intent_authentication_failure':
          return '決済認証に失敗しました。';
        case 'payment_method_unactivated':
          return '支払い方法がアクティブではありません。';
        case 'payment_intent_unexpected_state':
          return '決済が予期しない状態です。';
        default:
          break;
      }
    }

    // declineCodeがある場合（カード拒否）
    if (error.declineCode != null) {
      return _getCardDeclinedMessage(error.declineCode);
    }

    // localizedMessageを使用
    return error.localizedMessage ?? '決済に失敗しました。';
  }

  /// デバッグ用：詳細なエラー情報を取得
  static Map<String, dynamic> getDebugInfo(StripeException exception) {
    final error = exception.error;

    return {
      'code': error.code.toString(),
      'message': error.message,
      'localizedMessage': error.localizedMessage,
      'stripeErrorCode': error.stripeErrorCode,
      'declineCode': error.declineCode,
      'type': error.type,
      // paymentIntentプロパティは存在しないため削除
      'stackTrace': exception.toString(),
    };
  }

  /// ユーザー向けのシンプルなエラーメッセージ
  static String getSimpleMessage(StripeException exception) {
    final error = exception.error;

    switch (error.code) {
      case FailureCode.Failed:
        // declineCodeがある場合はカード拒否
        if (error.declineCode != null) {
          return 'カードが使用できません。別のカードをお試しください。';
        }
        return '決済エラーが発生しました。再度お試しください。';
      case FailureCode.Canceled:
        return '決済がキャンセルされました。';
      case FailureCode.Timeout:
        return '決済がタイムアウトしました。';
      default:
        return '決済エラーが発生しました。再度お試しください。';
    }
  }

  /// エラーが再試行可能かどうかを判定
  static bool isRetryable(StripeException exception) {
    final error = exception.error;

    switch (error.code) {
      case FailureCode.Timeout:
        return true;

      case FailureCode.Failed:
        // 一部のstripeErrorCodeは再試行可能
        return error.stripeErrorCode == 'payment_intent_unexpected_state';

      case FailureCode.Canceled:
      default:
        return false;
    }
  }
}
