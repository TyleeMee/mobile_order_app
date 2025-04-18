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
        fontFamily: 'Noto Sans JP',
        // * Use this to toggle Material 3 (defaults to true since Flutter 3.16)
        useMaterial3: true,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          // backgroundColor: mainColor,
          titleTextStyle: TextStyle(
            fontFamily: 'Noto Sans JP',
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
            textStyle: TextStyle(fontFamily: 'Noto Sans JP'),
            backgroundColor: mainColor, // background (button) color
            foregroundColor: Colors.white, // foreground (text) color
          ),
        ),
        //* 以下、Noto Sans SCがデフォルトで使用されるため、
        //* assets/fonts を使用できるようにNoto Sans JPにして
        //* オフライン時でも使用可（fontsファイルを大きくしたくないので中国語は極力入れない）
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontFamily: 'Noto Sans JP'),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            textStyle: TextStyle(fontFamily: 'Noto Sans JP'),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(fontFamily: 'Noto Sans JP'),
          unselectedLabelStyle: TextStyle(fontFamily: 'Noto Sans JP'),
        ),
        dialogTheme: DialogTheme(
          // タイトルのテキストスタイル
          titleTextStyle: TextStyle(
            fontFamily: 'Noto Sans JP',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          // 内容のテキストスタイル
          contentTextStyle: TextStyle(fontFamily: 'Noto Sans JP', fontSize: 16),
        ),
      ),
    );
  }
}
