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
  //*アラートダイアログのエラーメッセージに表示されるフォントは
  //*デフォルトで「Noto Sans SC」(中国語簡体字)なので、assets/fontsを使うためにフォントを指定
  final TextStyle titleStyle = TextStyle(
    fontFamily: 'Noto Sans JP',
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  final TextStyle contentStyle = TextStyle(
    fontFamily: 'Noto Sans JP',
    fontSize: 16,
  );

  final TextStyle buttonStyle = TextStyle(fontFamily: 'Noto Sans JP');

  return showDialog(
    context: context,
    barrierDismissible: cancelActionText != null,
    builder:
        (context) => AlertDialog.adaptive(
          title: Text(title, style: titleStyle),
          content: content != null ? Text(content, style: contentStyle) : null,
          actions:
              kIsWeb || !Platform.isIOS
                  ? <Widget>[
                    if (cancelActionText != null)
                      TextButton(
                        child: Text(cancelActionText, style: buttonStyle),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    TextButton(
                      child: Text(defaultActionText, style: buttonStyle),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ]
                  : <Widget>[
                    if (cancelActionText != null)
                      CupertinoDialogAction(
                        child: Text(cancelActionText, style: buttonStyle),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                    CupertinoDialogAction(
                      child: Text(defaultActionText, style: buttonStyle),
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
