import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';

//プラットフォームに対応したMaterialまたはCupertinoダイアログを表示する関数
Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  String defaultActionText = 'OK',
}) async {
  return showDialog(
    context: context,
    // * キャンセルボタンがある場合にのみ、ダイアログを閉じられるようにする。
    barrierDismissible: cancelActionText != null,
    builder:
        (context) => AlertDialog.adaptive(
          title: Text(title),
          content: content != null ? Text(content) : null,
          actions:
              kIsWeb || !Platform.isIOS
                  ? <Widget>[
                    if (cancelActionText != null)
                      TextButton(
                        child: Text(cancelActionText),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    TextButton(
                      child: Text(defaultActionText),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ]
                  : <Widget>[
                    if (cancelActionText != null)
                      CupertinoDialogAction(
                        child: Text(cancelActionText),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    CupertinoDialogAction(
                      child: Text(defaultActionText),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
        ),
  );
}

Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) => showAlertDialog(
  context: context,
  title: title,
  content: exception.toString(),
  defaultActionText: 'OK'.hardcoded,
);
