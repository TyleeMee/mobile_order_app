import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_order_app/src/features/cart/application/cart_notifier.dart';
import 'package:mobile_order_app/src/features/cart/presentation/shopping_cart/shopping_cart_screen.dart';
import 'package:mobile_order_app/src/features/checkout/presentation/checkout_screen.dart';
import 'package:mobile_order_app/src/features/checkout/presentation/payment_processing_screen.dart';
import 'package:mobile_order_app/src/features/order/presentation/current_order_screen.dart';
import 'package:mobile_order_app/src/features/products/presentation/product_screen.dart';
import 'package:mobile_order_app/src/features/products/presentation/products_list_screen.dart';
import 'package:mobile_order_app/src/routing/not_found_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute {
  home,
  product,
  cart,
  checkout,
  currentOrder,
  processing,
  orders,
  account,
  signIn,
}

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
            redirect: (BuildContext context, GoRouterState state) {
              // ProviderScope.containerOfを使ってProviderにアクセス
              final container = ProviderScope.containerOf(context);
              final cartItemsCount = container.read(cartItemsCountProvider);
              // cart内のアイテムが0の時は/にリダイレクト
              if (cartItemsCount == 0) {
                return '/';
              }
              return null;
            },
            routes: [
              GoRoute(
                path: 'checkout',
                name: AppRoute.checkout.name,
                builder: (context, state) => const CheckoutScreen(),
                redirect: (BuildContext context, GoRouterState state) {
                  // ProviderScope.containerOfを使ってProviderにアクセス
                  final container = ProviderScope.containerOf(context);
                  final cartItemsCount = container.read(cartItemsCountProvider);
                  // cart内のアイテムが0の時は/にリダイレクト
                  if (cartItemsCount == 0) {
                    return '/';
                  }
                  return null;
                },
              ),
              GoRoute(
                path: 'processing',
                name: AppRoute.processing.name,
                builder: (context, state) => const PaymentProcessingScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'currentOrder/:id',
            name: AppRoute.currentOrder.name,
            builder: (context, state) {
              final orderId = state.pathParameters['id']!;
              return CurrentOrderScreen(orderId: orderId);
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
