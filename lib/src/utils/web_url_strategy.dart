import 'package:flutter/foundation.dart';

// WebプラットフォームとそれLでないプラットフォーム両方で動作するURLヘルパー
class UrlHelper {
  static Uri getCurrentUrl() {
    if (kIsWeb) {
      // Webプラットフォームの場合、Uri.baseを使用
      return Uri.parse(Uri.base.toString());
    } else {
      // 非Webプラットフォームの場合
      return Uri.parse('');
    }
  }
}
