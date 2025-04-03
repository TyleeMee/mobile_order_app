import 'package:flutter/material.dart';

/// error message用の赤の[Text]
class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(this.errorMessage, {super.key});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: Theme.of(
        context,
      ).textTheme.titleLarge!.copyWith(color: Colors.red),
    );
  }
}
