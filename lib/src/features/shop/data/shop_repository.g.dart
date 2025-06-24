// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shopRepositoryHash() => r'f02dbfded717bd01347fe409ad447bfce9410477';

/// See also [shopRepository].
@ProviderFor(shopRepository)
final shopRepositoryProvider = Provider<ShopRepository>.internal(
  shopRepository,
  name: r'shopRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$shopRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ShopRepositoryRef = ProviderRef<ShopRepository>;
String _$shopHash() => r'21e321f6ad6ea3d4f0cd0bca46804a76841dd12c';

/// 店舗を取得するProvider
///
/// Copied from [shop].
@ProviderFor(shop)
final shopProvider = AutoDisposeFutureProvider<Shop?>.internal(
  shop,
  name: r'shopProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$shopHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ShopRef = AutoDisposeFutureProviderRef<Shop?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
