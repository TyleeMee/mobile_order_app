import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_order_app/src/common_widgets/responsive_center.dart';
import 'package:mobile_order_app/src/constants/app_color.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/routing/app_router.dart';

class EmptyOrderView extends StatelessWidget {
  const EmptyOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: Sizes.p48),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: const [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Icon(
                    Icons.phone_android,
                    size: 200,
                    color: accentColor,
                  ),
                ),
                Positioned(
                  child: Icon(Icons.circle, size: 150, color: accentColor),
                ),
                Positioned(
                  bottom: 30,
                  right: 30,
                  child: Icon(
                    Icons.restaurant_rounded,
                    size: 90,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Sizes.p32),
            child: Text(
              '''オーダーはいつでもこちらの画面から確認できます。\n宜しければぜひメニューをご覧になってください。''',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          OutlinedButton(
            onPressed: () => context.goNamed(AppRoute.home.name),
            child: Text('メニュー画面に戻る'),
          ),
        ],
      ),
    );
  }
}
