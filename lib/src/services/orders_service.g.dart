// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderHash() => r'0057d44132073702c4c24d6e84fa5783c0e6bd3c';

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

/// See also [order].
@ProviderFor(order)
const orderProvider = OrderFamily();

/// See also [order].
class OrderFamily extends Family<AsyncValue<Order?>> {
  /// See also [order].
  const OrderFamily();

  /// See also [order].
  OrderProvider call(String orderId) {
    return OrderProvider(orderId);
  }

  @override
  OrderProvider getProviderOverride(covariant OrderProvider provider) {
    return call(provider.orderId);
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

/// See also [order].
class OrderProvider extends AutoDisposeFutureProvider<Order?> {
  /// See also [order].
  OrderProvider(String orderId)
    : this._internal(
        (ref) => order(ref as OrderRef, orderId),
        from: orderProvider,
        name: r'orderProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product') ? null : _$orderHash,
        dependencies: OrderFamily._dependencies,
        allTransitiveDependencies: OrderFamily._allTransitiveDependencies,
        orderId: orderId,
      );

  OrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

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
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Order?> createElement() {
    return _OrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrderRef on AutoDisposeFutureProviderRef<Order?> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _OrderProviderElement extends AutoDisposeFutureProviderElement<Order?>
    with OrderRef {
  _OrderProviderElement(super.provider);

  @override
  String get orderId => (origin as OrderProvider).orderId;
}

String _$ordersByIdsHash() => r'2361ede76690f647b43f34d24bb19b58d3ffdf12';

/// See also [ordersByIds].
@ProviderFor(ordersByIds)
const ordersByIdsProvider = OrdersByIdsFamily();

/// See also [ordersByIds].
class OrdersByIdsFamily extends Family<AsyncValue<List<Order>>> {
  /// See also [ordersByIds].
  const OrdersByIdsFamily();

  /// See also [ordersByIds].
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

/// See also [ordersByIds].
class OrdersByIdsProvider extends AutoDisposeFutureProvider<List<Order>> {
  /// See also [ordersByIds].
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

String _$createOrderHash() => r'64fcdc68cbe7f63ebd642396db00817384ef2646';

/// See also [createOrder].
@ProviderFor(createOrder)
const createOrderProvider = CreateOrderFamily();

/// See also [createOrder].
class CreateOrderFamily extends Family<AsyncValue<Order?>> {
  /// See also [createOrder].
  const CreateOrderFamily();

  /// See also [createOrder].
  CreateOrderProvider call(OrderData orderData) {
    return CreateOrderProvider(orderData);
  }

  @override
  CreateOrderProvider getProviderOverride(
    covariant CreateOrderProvider provider,
  ) {
    return call(provider.orderData);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createOrderProvider';
}

/// See also [createOrder].
class CreateOrderProvider extends AutoDisposeFutureProvider<Order?> {
  /// See also [createOrder].
  CreateOrderProvider(OrderData orderData)
    : this._internal(
        (ref) => createOrder(ref as CreateOrderRef, orderData),
        from: createOrderProvider,
        name: r'createOrderProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$createOrderHash,
        dependencies: CreateOrderFamily._dependencies,
        allTransitiveDependencies: CreateOrderFamily._allTransitiveDependencies,
        orderData: orderData,
      );

  CreateOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderData,
  }) : super.internal();

  final OrderData orderData;

  @override
  Override overrideWith(
    FutureOr<Order?> Function(CreateOrderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateOrderProvider._internal(
        (ref) => create(ref as CreateOrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderData: orderData,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Order?> createElement() {
    return _CreateOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateOrderProvider && other.orderData == orderData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderData.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateOrderRef on AutoDisposeFutureProviderRef<Order?> {
  /// The parameter `orderData` of this provider.
  OrderData get orderData;
}

class _CreateOrderProviderElement
    extends AutoDisposeFutureProviderElement<Order?>
    with CreateOrderRef {
  _CreateOrderProviderElement(super.provider);

  @override
  OrderData get orderData => (origin as CreateOrderProvider).orderData;
}

String _$updateOrderStatusHash() => r'2049eb4fa1e20fef86c3c755aa10762d39682d4e';

/// See also [updateOrderStatus].
@ProviderFor(updateOrderStatus)
const updateOrderStatusProvider = UpdateOrderStatusFamily();

/// See also [updateOrderStatus].
class UpdateOrderStatusFamily extends Family<AsyncValue<bool>> {
  /// See also [updateOrderStatus].
  const UpdateOrderStatusFamily();

  /// See also [updateOrderStatus].
  UpdateOrderStatusProvider call({
    required String orderId,
    required OrderStatus newStatus,
  }) {
    return UpdateOrderStatusProvider(orderId: orderId, newStatus: newStatus);
  }

  @override
  UpdateOrderStatusProvider getProviderOverride(
    covariant UpdateOrderStatusProvider provider,
  ) {
    return call(orderId: provider.orderId, newStatus: provider.newStatus);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateOrderStatusProvider';
}

/// See also [updateOrderStatus].
class UpdateOrderStatusProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [updateOrderStatus].
  UpdateOrderStatusProvider({
    required String orderId,
    required OrderStatus newStatus,
  }) : this._internal(
         (ref) => updateOrderStatus(
           ref as UpdateOrderStatusRef,
           orderId: orderId,
           newStatus: newStatus,
         ),
         from: updateOrderStatusProvider,
         name: r'updateOrderStatusProvider',
         debugGetCreateSourceHash:
             const bool.fromEnvironment('dart.vm.product')
                 ? null
                 : _$updateOrderStatusHash,
         dependencies: UpdateOrderStatusFamily._dependencies,
         allTransitiveDependencies:
             UpdateOrderStatusFamily._allTransitiveDependencies,
         orderId: orderId,
         newStatus: newStatus,
       );

  UpdateOrderStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
    required this.newStatus,
  }) : super.internal();

  final String orderId;
  final OrderStatus newStatus;

  @override
  Override overrideWith(
    FutureOr<bool> Function(UpdateOrderStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateOrderStatusProvider._internal(
        (ref) => create(ref as UpdateOrderStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
        newStatus: newStatus,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _UpdateOrderStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateOrderStatusProvider &&
        other.orderId == orderId &&
        other.newStatus == newStatus;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);
    hash = _SystemHash.combine(hash, newStatus.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateOrderStatusRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `orderId` of this provider.
  String get orderId;

  /// The parameter `newStatus` of this provider.
  OrderStatus get newStatus;
}

class _UpdateOrderStatusProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with UpdateOrderStatusRef {
  _UpdateOrderStatusProviderElement(super.provider);

  @override
  String get orderId => (origin as UpdateOrderStatusProvider).orderId;
  @override
  OrderStatus get newStatus => (origin as UpdateOrderStatusProvider).newStatus;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
