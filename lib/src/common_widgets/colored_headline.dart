import 'package:flutter/material.dart';

import '../constants/app_color.dart';
import '../constants/app_sizes.dart';

class ColoredHeadline extends StatelessWidget {
  const ColoredHeadline({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backGroundColorLightGrey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Sizes.p12,
          Sizes.p16,
          Sizes.p12,
          Sizes.p8,
        ),
        child: child,
      ),
    );
  }
}
