import 'package:flutter/material.dart';
import 'package:mobile_order_app/src/constants/breakpoints.dart';

/// 再利用可能なウィジェットで、コンテンツの最大幅制約付きで子ウィジェットを表示
/// 利用可能な幅が最大幅より大きい場合、子ウィジェットは水平方向に中央配置。
/// 利用可能な幅が最大幅より小さい場合、子ウィジェットは利用可能な全幅を使用。
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    this.maxContentWidth = Breakpoint.tablet,
    this.padding = EdgeInsets.zero,
    required this.child,
  });
  final double maxContentWidth;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return
    // Alignを使用して水平方向中央・垂直方向制御可能にする
    Align(
      alignment: Alignment.topCenter,
      // ConstrainedBoxで最大幅を指定
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
