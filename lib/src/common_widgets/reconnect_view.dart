import 'package:flutter/material.dart';

class ReconnectView extends StatefulWidget {
  const ReconnectView({super.key, this.onPressed, this.message = 'エラーが発生しました'});
  final VoidCallback? onPressed;
  final String message;

  @override
  State<ReconnectView> createState() => _ReconnectViewState();
}

class _ReconnectViewState extends State<ReconnectView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_off, size: 64.0, color: Colors.grey),
          const SizedBox(height: 24.0),
          Text(
            widget.message,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
