// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ordersRepositoryHash() => r'7b2b7dbfd4bb43f53d206fe7c686a771635ded8e';

/// See also [ordersRepository].
@ProviderFor(ordersRepository)
final ordersRepositoryProvider = Provider<OrdersRepository>.internal(
  ordersRepository,
  name: r'ordersRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$ordersRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrdersRepositoryRef = ProviderRef<OrdersRepository>;
String _$ordersByIdsHash() => r'bd2c78a2ff6b0d815c35cf1536f47ca6314d4384';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

///OrderリストをOrderIdsから取得
///
/// Copied from [ordersByIds].
@ProviderFor(ordersByIds)
const ordersByIdsProvider = OrdersByIdsFamily();

///OrderリストをOrderIdsから取得
///
/// Copied from [ordersByIds].
class OrdersByIdsFamily extends Family<AsyncValue<List<Order>>> {
  ///OrderリストをOrderIdsから取得
  ///
  /// Copied from [ordersByIds].
  const OrdersByIdsFamily();

  ///OrderリストをOrderIdsから取得
  ///
  /// Copied from [ordersByIds].
  OrdersByIdsProvider call(List<String> orderIds) {
    return OrdersByIdsProvider(orderIds);
  }

  @override
  OrdersByIdsProvider getProviderOverride(
    covariant OrdersByIdsProvider provider,
  ) {
    return call(provider.orderIds);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ordersByIdsProvider';
}

///OrderリストをOrderIdsから取得
///
/// Copied from [ordersByIds].
class OrdersByIdsProvider extends AutoDisposeFutureProvider<List<Order>> {
  ///OrderリストをOrderIdsから取得
  ///
  /// Copied from [ordersByIds].
  OrdersByIdsProvider(List<String> orderIds)
    : this._internal(
        (ref) => ordersByIds(ref as OrdersByIdsRef, orderIds),
        from: ordersByIdsProvider,
        name: r'ordersByIdsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$ordersByIdsHash,
        dependencies: OrdersByIdsFamily._dependencies,
        allTransitiveDependencies: OrdersByIdsFamily._allTransitiveDependencies,
        orderIds: orderIds,
      );

  OrdersByIdsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderIds,
  }) : super.internal();

  final List<String> orderIds;

  @override
  Override overrideWith(
    FutureOr<List<Order>> Function(OrdersByIdsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrdersByIdsProvider._internal(
        (ref) => create(ref as OrdersByIdsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderIds: orderIds,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Order>> createElement() {
    return _OrdersByIdsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrdersByIdsProvider && other.orderIds == orderIds;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderIds.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrdersByIdsRef on AutoDisposeFutureProviderRef<List<Order>> {
  /// The parameter `orderIds` of this provider.
  List<String> get orderIds;
}

class _OrdersByIdsProviderElement
    extends AutoDisposeFutureProviderElement<List<Order>>
    with OrdersByIdsRef {
  _OrdersByIdsProviderElement(super.provider);

  @override
  List<String> get orderIds => (origin as OrdersByIdsProvider).orderIds;
}

String _$orderHash() => r'7437005bc1a458ebb9570ba06a07e79ad348f425';

/// 特定の商品を取得するProvider
///
/// Copied from [order].
@ProviderFor(order)
const orderProvider = OrderFamily();

/// 特定の商品を取得するProvider
///
/// Copied from [order].
class OrderFamily extends Family<AsyncValue<Order?>> {
  /// 特定の商品を取得するProvider
  ///
  /// Copied from [order].
  const OrderFamily();

  /// 特定の商品を取得するProvider
  ///
  /// Copied from [order].
  OrderProvider call(String id) {
    return OrderProvider(id);
  }

  @override
  OrderProvider getProviderOverride(covariant OrderProvider provider) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'orderProvider';
}

/// 特定の商品を取得するProvider
///
/// Copied from [order].
class OrderProvider extends AutoDisposeFutureProvider<Order?> {
  /// 特定の商品を取得するProvider
  ///
  /// Copied from [order].
  OrderProvider(String id)
    : this._internal(
        (ref) => order(ref as OrderRef, id),
        from: orderProvider,
        name: r'orderProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product') ? null : _$orderHash,
        dependencies: OrderFamily._dependencies,
        allTransitiveDependencies: OrderFamily._allTransitiveDependencies,
        id: id,
      );

  OrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(FutureOr<Order?> Function(OrderRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: OrderProvider._internal(
        (ref) => create(ref as OrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Order?> createElement() {
    return _OrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrderRef on AutoDisposeFutureProviderRef<Order?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _OrderProviderElement extends AutoDisposeFutureProviderElement<Order?>
    with OrderRef {
  _OrderProviderElement(super.provider);

  @override
  String get id => (origin as OrderProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
