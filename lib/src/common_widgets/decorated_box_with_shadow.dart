import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

/// Custom [DecoratedBox] widget with shadow to be used at the bottom of the
/// screen on mobile. Useful for pinning CTAs such as checkout buttons etc.

class DecoratedBoxWithShadow extends StatelessWidget {
  const DecoratedBoxWithShadow({super.key, required this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, -Sizes.p4),
            blurRadius: Sizes.p4,
            spreadRadius: -Sizes.p4,
          ),
        ],
      ),
      child: Padding(padding: const EdgeInsets.all(Sizes.p12), child: child),
    );
  }
}
