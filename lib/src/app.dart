import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/constants/app_color.dart';
import 'package:mobile_order_app/src/constants/app_sizes.dart';
import 'package:mobile_order_app/src/localization/string_hardcoded.dart';
import 'package:mobile_order_app/src/routing/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) => 'モバイルオーダー'.hardcoded,
      theme: ThemeData(
        // * Use this to toggle Material 3 (defaults to true since Flutter 3.16)
        useMaterial3: true,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          // backgroundColor: mainColor,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.p20,
            // color: Colors.white,
          ),
          elevation: 3,
          shadowColor: Colors.grey,
          surfaceTintColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor, // background (button) color
            foregroundColor: Colors.white, // foreground (text) color
          ),
        ),
        //TODO 不要なものを消去する
        // floatingActionButtonTheme: const FloatingActionButtonThemeData(
        //   backgroundColor: Colors.black, // background (button) color
        //   foregroundColor: Colors.white, // foreground (text) color
        // ),
      ),
    );
  }
}
