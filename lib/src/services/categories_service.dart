import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/models/category.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import './api_client.dart';

part 'categories_service.g.dart';

class CategoriesService {
  // カテゴリー一覧取得API
  static Future<List<Category>> getCategories(String ownerId) async {
    try {
      final response = await ApiClient.fetch(
        '/api/categories?ownerId=$ownerId',
      );
      if (response == null) {
        return [];
      }

      // レスポンスが配列であることを確認
      if (response is List) {
        return response.map((item) => Category.fromMap(item)).toList();
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

  // 特定のカテゴリー取得API
  static Future<Category?> getCategory(String ownerId, String id) async {
    try {
      final response = await ApiClient.fetch(
        '/api/categories/$id?ownerId=$ownerId',
      );
      if (response == null) {
        return null;
      }
      return Category.fromMap(response);
    } catch (error) {
      // エラーメッセージが「APIエラー: 404」を含むか確認
      if (error.toString().contains('APIエラー: 404')) {
        return null;
      }
      rethrow;
    }
  }
}

//+++++Provider+++++

@riverpod
Future<List<Category>> categories(Ref ref) async {
  final ownerId = await ref.watch(validOwnerIdProvider.future);
  return CategoriesService.getCategories(ownerId);
}

@riverpod
Future<Category?> category(Ref ref, String categoryId) async {
  final ownerId = await ref.watch(validOwnerIdProvider.future);
  return CategoriesService.getCategory(ownerId, categoryId);
}
