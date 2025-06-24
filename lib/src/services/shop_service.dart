import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/models/shop.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import './api_client.dart';

part 'shop_service.g.dart';

class ShopService {
  // 店舗データ取得API
  static Future<Shop?> getShop(String ownerId) async {
    try {
      final response = await ApiClient.fetch('/api/shop/$ownerId');
      if (response == null) {
        return null;
      }
      return Shop.fromMap(response);
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
Future<Shop?> shop(Ref ref) async {
  final ownerId = await ref.watch(validOwnerIdProvider.future);
  return ShopService.getShop(ownerId);
}
