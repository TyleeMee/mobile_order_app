// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsInCategoryHash() =>
    r'13f1c2092e31617ea44a1ac8f0a83a1e7187b222';

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

/// See also [productsInCategory].
@ProviderFor(productsInCategory)
const productsInCategoryProvider = ProductsInCategoryFamily();

/// See also [productsInCategory].
class ProductsInCategoryFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [productsInCategory].
  const ProductsInCategoryFamily();

  /// See also [productsInCategory].
  ProductsInCategoryProvider call(String categoryId) {
    return ProductsInCategoryProvider(categoryId);
  }

  @override
  ProductsInCategoryProvider getProviderOverride(
    covariant ProductsInCategoryProvider provider,
  ) {
    return call(provider.categoryId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productsInCategoryProvider';
}

/// See also [productsInCategory].
class ProductsInCategoryProvider
    extends AutoDisposeFutureProvider<List<Product>> {
  /// See also [productsInCategory].
  ProductsInCategoryProvider(String categoryId)
    : this._internal(
        (ref) => productsInCategory(ref as ProductsInCategoryRef, categoryId),
        from: productsInCategoryProvider,
        name: r'productsInCategoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productsInCategoryHash,
        dependencies: ProductsInCategoryFamily._dependencies,
        allTransitiveDependencies:
            ProductsInCategoryFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  ProductsInCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final String categoryId;

  @override
  Override overrideWith(
    FutureOr<List<Product>> Function(ProductsInCategoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsInCategoryProvider._internal(
        (ref) => create(ref as ProductsInCategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Product>> createElement() {
    return _ProductsInCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsInCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductsInCategoryRef on AutoDisposeFutureProviderRef<List<Product>> {
  /// The parameter `categoryId` of this provider.
  String get categoryId;
}

class _ProductsInCategoryProviderElement
    extends AutoDisposeFutureProviderElement<List<Product>>
    with ProductsInCategoryRef {
  _ProductsInCategoryProviderElement(super.provider);

  @override
  String get categoryId => (origin as ProductsInCategoryProvider).categoryId;
}

String _$productHash() => r'de0e99769b322dc147c79632d98f0ede3c44ddc2';

/// See also [product].
@ProviderFor(product)
const productProvider = ProductFamily();

/// See also [product].
class ProductFamily extends Family<AsyncValue<Product?>> {
  /// See also [product].
  const ProductFamily();

  /// See also [product].
  ProductProvider call(String productId) {
    return ProductProvider(productId);
  }

  @override
  ProductProvider getProviderOverride(covariant ProductProvider provider) {
    return call(provider.productId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productProvider';
}

/// See also [product].
class ProductProvider extends AutoDisposeFutureProvider<Product?> {
  /// See also [product].
  ProductProvider(String productId)
    : this._internal(
        (ref) => product(ref as ProductRef, productId),
        from: productProvider,
        name: r'productProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productHash,
        dependencies: ProductFamily._dependencies,
        allTransitiveDependencies: ProductFamily._allTransitiveDependencies,
        productId: productId,
      );

  ProductProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  Override overrideWith(
    FutureOr<Product?> Function(ProductRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductProvider._internal(
        (ref) => create(ref as ProductRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Product?> createElement() {
    return _ProductProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductRef on AutoDisposeFutureProviderRef<Product?> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _ProductProviderElement extends AutoDisposeFutureProviderElement<Product?>
    with ProductRef {
  _ProductProviderElement(super.provider);

  @override
  String get productId => (origin as ProductProvider).productId;
}

String _$productsByIdsHash() => r'e765007f797051ee65f6e3303df3dec549193a8d';

/// See also [productsByIds].
@ProviderFor(productsByIds)
const productsByIdsProvider = ProductsByIdsFamily();

/// See also [productsByIds].
class ProductsByIdsFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [productsByIds].
  const ProductsByIdsFamily();

  /// See also [productsByIds].
  ProductsByIdsProvider call(List<String> productIds) {
    return ProductsByIdsProvider(productIds);
  }

  @override
  ProductsByIdsProvider getProviderOverride(
    covariant ProductsByIdsProvider provider,
  ) {
    return call(provider.productIds);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productsByIdsProvider';
}

/// See also [productsByIds].
class ProductsByIdsProvider extends AutoDisposeFutureProvider<List<Product>> {
  /// See also [productsByIds].
  ProductsByIdsProvider(List<String> productIds)
    : this._internal(
        (ref) => productsByIds(ref as ProductsByIdsRef, productIds),
        from: productsByIdsProvider,
        name: r'productsByIdsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productsByIdsHash,
        dependencies: ProductsByIdsFamily._dependencies,
        allTransitiveDependencies:
            ProductsByIdsFamily._allTransitiveDependencies,
        productIds: productIds,
      );

  ProductsByIdsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productIds,
  }) : super.internal();

  final List<String> productIds;

  @override
  Override overrideWith(
    FutureOr<List<Product>> Function(ProductsByIdsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsByIdsProvider._internal(
        (ref) => create(ref as ProductsByIdsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productIds: productIds,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Product>> createElement() {
    return _ProductsByIdsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsByIdsProvider && other.productIds == productIds;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productIds.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductsByIdsRef on AutoDisposeFutureProviderRef<List<Product>> {
  /// The parameter `productIds` of this provider.
  List<String> get productIds;
}

class _ProductsByIdsProviderElement
    extends AutoDisposeFutureProviderElement<List<Product>>
    with ProductsByIdsRef {
  _ProductsByIdsProviderElement(super.provider);

  @override
  List<String> get productIds => (origin as ProductsByIdsProvider).productIds;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
