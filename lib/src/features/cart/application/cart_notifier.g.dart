// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartItemsCountHash() => r'f4e933796a79e13769d48d80999d2d93cd6ff0f0';

/// See also [cartItemsCount].
@ProviderFor(cartItemsCount)
final cartItemsCountProvider = AutoDisposeProvider<int>.internal(
  cartItemsCount,
  name: r'cartItemsCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cartItemsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartItemsCountRef = AutoDisposeProviderRef<int>;
String _$cartTotalHash() => r'5ac37227d337e7c979a90e5484d533438bae8918';

/// See also [cartTotal].
@ProviderFor(cartTotal)
final cartTotalProvider = AutoDisposeFutureProvider<double>.internal(
  cartTotal,
  name: r'cartTotalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartTotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartTotalRef = AutoDisposeFutureProviderRef<double>;
String _$cartProductIdsHash() => r'78d6c9b04eed4d9d6a632cbd204ee9ce3a32a229';

///ショッピングカートのProductsリストに使用
///
/// Copied from [cartProductIds].
@ProviderFor(cartProductIds)
final cartProductIdsProvider = AutoDisposeProvider<List<ProductID>>.internal(
  cartProductIds,
  name: r'cartProductIdsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cartProductIdsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartProductIdsRef = AutoDisposeProviderRef<List<ProductID>>;
String _$cartNotifierHash() => r'0f1f2edb4498ec62987d1bc444aef9dfe9261629';

/// See also [CartNotifier].
@ProviderFor(CartNotifier)
final cartNotifierProvider = NotifierProvider<CartNotifier, Cart>.internal(
  CartNotifier.new,
  name: r'cartNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CartNotifier = Notifier<Cart>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
