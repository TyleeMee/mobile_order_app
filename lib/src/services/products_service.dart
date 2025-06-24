import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/models/product.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import './api_client.dart';

part 'products_service.g.dart';

class ProductsService {
  // カテゴリ内の商品一覧取得API
  static Future<List<Product>> getProductsInCategory(
    String ownerId,
    String categoryId,
  ) async {
    try {
      final response = await ApiClient.fetch(
        '/api/products/category/$categoryId?ownerId=$ownerId',
      );
      if (response == null) {
        return [];
      }

      // レスポンスが配列であることを確認
      if (response is List) {
        return response.map((item) => Product.fromMap(item)).toList();
      } else {
        // レスポンスが適切な形式でない場合は空のリストを返す
        return [];
      }
    } catch (error) {
      // エラーメッセージが「APIエラー: 404」を含むか確認
      if (error.toString().contains('APIエラー: 404')) {
        return [];
      }
      rethrow;
    }
  }

  // 特定の商品取得API
  static Future<Product?> getProduct(String ownerId, String id) async {
    try {
      final response = await ApiClient.fetch(
        '/api/products/$id?ownerId=$ownerId',
      );
      if (response == null) {
        return null;
      }
      return Product.fromMap(response);
    } catch (error) {
      // エラーメッセージが「APIエラー: 404」を含むか確認
      if (error.toString().contains('APIエラー: 404')) {
        return null;
      }
      rethrow;
    }
  }

  // 複数の商品IDから商品リストを取得するAPI
  static Future<List<Product>> productsByIds(
    String ownerId,
    List<ProductID> productIds,
  ) async {
    try {
      // クエリパラメータとしてproductIdsを送信
      final queryParams = productIds.map((id) => 'ids=$id').join('&');
      final response = await ApiClient.fetch(
        '/api/products?ownerId=$ownerId&$queryParams',
      );

      if (response == null) {
        return [];
      }

      // レスポンスが配列であることを確認
      if (response is List) {
        return response.map((item) => Product.fromMap(item)).toList();
      } else {
        // レスポンスが適切な形式でない場合は空のリストを返す
        return [];
      }
    } catch (error) {
      // エラーメッセージが「APIエラー: 404」を含むか確認
      if (error.toString().contains('APIエラー: 404')) {
        return [];
      }
      rethrow;
    }
  }
}

//+++++Provider+++++

@riverpod
Future<List<Product>> productsInCategory(Ref ref, String categoryId) async {
  final ownerId = await ref.watch(validOwnerIdProvider.future);
  return ProductsService.getProductsInCategory(ownerId, categoryId);
}

@riverpod
Future<Product?> product(Ref ref, String productId) async {
  final ownerId = await ref.watch(validOwnerIdProvider.future);
  return ProductsService.getProduct(ownerId, productId);
}

@riverpod
Future<List<Product>> productsByIds(Ref ref, List<ProductID> productIds) async {
  final ownerId = await ref.watch(validOwnerIdProvider.future);
  return ProductsService.productsByIds(ownerId, productIds);
}
