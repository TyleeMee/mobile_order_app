import 'package:flutter/foundation.dart';

// WebプラットフォームとそれLでないプラットフォーム両方で動作するURLヘルパー
class UrlHelper {
  static Uri getCurrentUrl() {
    if (kIsWeb) {
      // Webプラットフォームの場合
      return _WebUrlHelper.getCurrentUrl();
    } else {
      // 非Webプラットフォームの場合
      return Uri.parse('');
    }
  }
}

// Webプラットフォーム専用の実装
class _WebUrlHelper {
  static Uri getCurrentUrl() {
    // このクラスはWebプラットフォームでのみインポートされる
    if (kIsWeb) {
      // コンパイル時にダートコンパイラがJSのインポートを行う
      return _getLocationUrl();
    }
    return Uri.parse('');
  }

  // この部分はWebプラットフォームでのみコンパイル・実行される
  static Uri _getLocationUrl() {
    if (kIsWeb) {
      // JavaScriptインターオペラビリティを使用
      final location = _jsLocation();
      return Uri.parse(location);
    }
    return Uri.parse('');
  }

  // JS interopを使った実装
  static String _jsLocation() {
    if (kIsWeb) {
      // 以下はJavaScriptの「window.location.href」と同等
      return Uri.base.toString();
    }
    return '';
  }
}
