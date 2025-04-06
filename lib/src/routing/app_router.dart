import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_order_app/src/features/cart/presentation/shopping_cart/shopping_cart_screen.dart';
import 'package:mobile_order_app/src/features/products/presentation/product_screen.dart';
import 'package:mobile_order_app/src/features/products/presentation/products_list_screen.dart';
import 'package:mobile_order_app/src/routing/not_found_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// All the supported routes in the app.
/// By using an enum, we route by name using this syntax:
/// ```dart
/// context.goNamed(AppRoute.orders.name)
/// ```
enum AppRoute { home, product, cart, checkout, orders, account, signIn }

/// アプリ内のすべてのルートを定義する GoRouter インスタンス
@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    //GoRouterの内部動作（ルート変更、リダイレクト、エラーなど）に関する詳細なログ
    //TODO 本番環境ではfalseにするか消去
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const ProductsListScreen(),
        routes: [
          GoRoute(
            path: 'product/:id',
            name: AppRoute.product.name,
            builder: (context, state) {
              final productId = state.pathParameters['id']!;
              return ProductScreen(productId: productId);
            },
          ),
          GoRoute(
            path: 'cart',
            name: AppRoute.cart.name,
            pageBuilder:
                (context, state) => const MaterialPage(
                  fullscreenDialog: true,
                  child: ShoppingCartScreen(),
                ),
            //           routes: [
            //             GoRoute(
            //               path: 'checkout',
            //               name: AppRoute.checkout.name,
            //               pageBuilder: (context, state) => const MaterialPage(
            //                 fullscreenDialog: true,
            //                 child: CheckoutScreen(),
            //               ),
            //             ),
            //           ],
          ),
          //         GoRoute(
          //           path: 'orders',
          //           name: AppRoute.orders.name,
          //           pageBuilder: (context, state) => const MaterialPage(
          //             fullscreenDialog: true,
          //             child: OrdersListScreen(),
          //           ),
          //         ),
          //         GoRoute(
          //           path: 'account',
          //           name: AppRoute.account.name,
          //           pageBuilder: (context, state) => const MaterialPage(
          //             fullscreenDialog: true,
          //             child: AccountScreen(),
          //           ),
          //         ),
          //         GoRoute(
          //           path: 'signIn',
          //           name: AppRoute.signIn.name,
          //           pageBuilder: (context, state) => const MaterialPage(
          //             fullscreenDialog: true,
          //             child: EmailPasswordSignInScreen(
          //               formType: EmailPasswordSignInFormType.signIn,
          //             ),
          //           ),
          //         ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
