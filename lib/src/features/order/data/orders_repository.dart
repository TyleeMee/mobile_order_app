import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/features/order/domain/order.dart';
import 'package:mobile_order_app/src/utils/config/app_config_notifier.dart';
import 'package:mobile_order_app/src/utils/firebase/firestore_converters.dart';
import 'package:mobile_order_app/src/utils/firebase/firestore_service.dart';
import 'package:mobile_order_app/src/utils/firebase/repository_base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'orders_repository.g.dart';

class OrdersRepository {
  OrdersRepository(this._firestore, this._firestoreService, this._ref);
  final fs.FirebaseFirestore _firestore;
  final FirestoreService _firestoreService;
  final Ref _ref;

  // コレクションパス関連のヘルパーメソッド
  String _ownerPath(String ownerId) => 'owners/$ownerId';
  String _ordersPath(String ownerId) => '${_ownerPath(ownerId)}/orders';
  String _orderPath(String ownerId, OrderID id) =>
      '${_ordersPath(ownerId)}/$id';

  // 現在のオーナーIDを取得
  Future<String> _getValidOwnerId() {
    return _ref.read(validOwnerIdProvider.future);
  }

  // 注文ドキュメント参照を取得
  Future<fs.DocumentReference<Order>> _orderRef(OrderID id) async {
    final ownerId = await _getValidOwnerId();
    return _firestore
        .doc(_orderPath(ownerId, id))
        .withConverter(
          fromFirestore:
              (doc, _) => FirestoreConverters.toOrder(doc.id, doc.data()!),
          toFirestore: (Order order, options) => order.toFirestoreMap(),
        );
  }

  // 注文コレクション参照を取得
  Future<fs.CollectionReference<Order>> _ordersRef() async {
    final ownerId = await _getValidOwnerId();
    return _firestore
        .collection(_ordersPath(ownerId))
        .withConverter(
          fromFirestore:
              (doc, _) => FirestoreConverters.toOrder(doc.id, doc.data()!),
          toFirestore: (Order order, options) => order.toFirestoreMap(),
        );
  }

  Future<fs.CollectionReference<OrderData>> _orderDataRef() async {
    final ownerId = await _getValidOwnerId();
    return _firestore
        .collection(_ordersPath(ownerId))
        .withConverter(
          fromFirestore: (doc, _) => OrderData.fromMap(doc.data()!),
          toFirestore:
              (OrderData orderData, options) => orderData.toFirestoreMap(),
        );
  }

  //=====作成メソッド=====

  Future<Order> addOrder(OrderData orderData) async {
    try {
      final orderDataRef = await _orderDataRef();
      final orderDataDocRef = await _firestoreService.addDocument<OrderData>(
        colRef: orderDataRef,
        data: orderData,
      );
      return Order(
        id: orderDataDocRef.id,
        pickupId: orderData.pickupId,
        items: orderData.items,
        productIds: orderData.productIds,
        orderStatus: orderData.orderStatus,
        orderDate: orderData.orderDate,
        total: orderData.total,
      );
    } catch (e) {
      throw RepositoryException('オーダーの追加に失敗しました', originalError: e);
    }
  }

  //=====取得メソッド=====
  //TODO キャンセルされたOrderをUIに反映させるwatchOrdersByIdsメソッドを追加する
  ///Orderリストを取得（キャッシュフォールバック付き）
  Future<List<Order>> fetchOrdersByIds(List<OrderID> orderIds) async {
    try {
      if (orderIds.isEmpty) {
        return [];
      }

      final ordersRef = await _ordersRef();
      final query = ordersRef.where(fs.FieldPath.documentId, whereIn: orderIds);

      // Orderを取得
      final orders = await _firestoreService.getCollection(
        query: query,
        useCacheFallback: true,
      );

      // orderIdsの順序に合わせて商品を取得
      final requestedOrders = <Order>[];
      final orderMap = {for (var order in orders) order.id: order};

      for (var id in orderIds) {
        if (orderMap.containsKey(id)) {
          requestedOrders.add(orderMap[id]!);
        }
      }

      return requestedOrders;
    } catch (e) {
      throw RepositoryException('オーダーの取得に失敗しました', originalError: e);
    }
  }

  //=====更新メソッド=====
  /// 注文ステータスを更新する
  Future<void> updateOrderStatus(OrderID id, OrderStatus newStatus) async {
    try {
      // 注文ドキュメント参照を取得
      final orderRef = await _orderRef(id);

      // 更新用データの準備
      final updateData = {'orderStatus': newStatus.toStorageString()};

      // ドキュメントを更新
      await _firestoreService.updateDocument(
        docRef: orderRef,
        data: updateData,
      );
    } catch (e) {
      throw RepositoryException('オーダーステータスの更新に失敗しました', originalError: e);
    }
  }

  /// 特定のオーダーを取得（キャッシュフォールバック付き）
  Future<Order?> fetchOrder(OrderID id) async {
    try {
      final orderRef = await _orderRef(id);
      return await _firestoreService.getDocument(
        docRef: orderRef,
        useCacheFallback: true,
      );
    } catch (e) {
      throw RepositoryException('オーダーの取得に失敗しました', originalError: e);
    }
  }
}

//+++++Provider+++++

@Riverpod(keepAlive: true)
OrdersRepository ordersRepository(Ref ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return OrdersRepository(fs.FirebaseFirestore.instance, firestoreService, ref);
}

///OrderリストをOrderIdsから取得
@riverpod
Future<List<Order>> ordersByIds(Ref ref, List<OrderID> orderIds) {
  final ordersRepository = ref.watch(ordersRepositoryProvider);
  return ordersRepository.fetchOrdersByIds(orderIds);
}

/// 特定の商品を取得するProvider
@riverpod
Future<Order?> order(Ref ref, OrderID id) async {
  final ordersRepository = ref.watch(ordersRepositoryProvider);
  return ordersRepository.fetchOrder(id);
}
