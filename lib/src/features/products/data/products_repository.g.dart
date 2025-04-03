// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsRepositoryHash() =>
    r'2b534b4abbfd1df0509b79f79965d43940a9b8f5';

/// See also [productsRepository].
@ProviderFor(productsRepository)
final productsRepositoryProvider = Provider<ProductsRepository>.internal(
  productsRepository,
  name: r'productsRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsRepositoryRef = ProviderRef<ProductsRepository>;
String _$productsInCategoryFutureHash() =>
    r'b17bbc0c519bf329efe07769ceba5bd5364a8cb3';

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

/// See also [productsInCategoryFuture].
@ProviderFor(productsInCategoryFuture)
const productsInCategoryFutureProvider = ProductsInCategoryFutureFamily();

/// See also [productsInCategoryFuture].
class ProductsInCategoryFutureFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [productsInCategoryFuture].
  const ProductsInCategoryFutureFamily();

  /// See also [productsInCategoryFuture].
  ProductsInCategoryFutureProvider call(String id) {
    return ProductsInCategoryFutureProvider(id);
  }

  @override
  ProductsInCategoryFutureProvider getProviderOverride(
    covariant ProductsInCategoryFutureProvider provider,
  ) {
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
  String? get name => r'productsInCategoryFutureProvider';
}

/// See also [productsInCategoryFuture].
class ProductsInCategoryFutureProvider
    extends AutoDisposeFutureProvider<List<Product>> {
  /// See also [productsInCategoryFuture].
  ProductsInCategoryFutureProvider(String id)
    : this._internal(
        (ref) =>
            productsInCategoryFuture(ref as ProductsInCategoryFutureRef, id),
        from: productsInCategoryFutureProvider,
        name: r'productsInCategoryFutureProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productsInCategoryFutureHash,
        dependencies: ProductsInCategoryFutureFamily._dependencies,
        allTransitiveDependencies:
            ProductsInCategoryFutureFamily._allTransitiveDependencies,
        id: id,
      );

  ProductsInCategoryFutureProvider._internal(
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
  Override overrideWith(
    FutureOr<List<Product>> Function(ProductsInCategoryFutureRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsInCategoryFutureProvider._internal(
        (ref) => create(ref as ProductsInCategoryFutureRef),
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
  AutoDisposeFutureProviderElement<List<Product>> createElement() {
    return _ProductsInCategoryFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsInCategoryFutureProvider && other.id == id;
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
mixin ProductsInCategoryFutureRef
    on AutoDisposeFutureProviderRef<List<Product>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductsInCategoryFutureProviderElement
    extends AutoDisposeFutureProviderElement<List<Product>>
    with ProductsInCategoryFutureRef {
  _ProductsInCategoryFutureProviderElement(super.provider);

  @override
  String get id => (origin as ProductsInCategoryFutureProvider).id;
}

String _$productsInCategoryStreamHash() =>
    r'1129b192f80f04e5aac753e57bec2439155c353f';

/// See also [productsInCategoryStream].
@ProviderFor(productsInCategoryStream)
const productsInCategoryStreamProvider = ProductsInCategoryStreamFamily();

/// See also [productsInCategoryStream].
class ProductsInCategoryStreamFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [productsInCategoryStream].
  const ProductsInCategoryStreamFamily();

  /// See also [productsInCategoryStream].
  ProductsInCategoryStreamProvider call(String id) {
    return ProductsInCategoryStreamProvider(id);
  }

  @override
  ProductsInCategoryStreamProvider getProviderOverride(
    covariant ProductsInCategoryStreamProvider provider,
  ) {
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
  String? get name => r'productsInCategoryStreamProvider';
}

/// See also [productsInCategoryStream].
class ProductsInCategoryStreamProvider
    extends AutoDisposeStreamProvider<List<Product>> {
  /// See also [productsInCategoryStream].
  ProductsInCategoryStreamProvider(String id)
    : this._internal(
        (ref) =>
            productsInCategoryStream(ref as ProductsInCategoryStreamRef, id),
        from: productsInCategoryStreamProvider,
        name: r'productsInCategoryStreamProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productsInCategoryStreamHash,
        dependencies: ProductsInCategoryStreamFamily._dependencies,
        allTransitiveDependencies:
            ProductsInCategoryStreamFamily._allTransitiveDependencies,
        id: id,
      );

  ProductsInCategoryStreamProvider._internal(
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
  Override overrideWith(
    Stream<List<Product>> Function(ProductsInCategoryStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsInCategoryStreamProvider._internal(
        (ref) => create(ref as ProductsInCategoryStreamRef),
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
  AutoDisposeStreamProviderElement<List<Product>> createElement() {
    return _ProductsInCategoryStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsInCategoryStreamProvider && other.id == id;
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
mixin ProductsInCategoryStreamRef
    on AutoDisposeStreamProviderRef<List<Product>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductsInCategoryStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Product>>
    with ProductsInCategoryStreamRef {
  _ProductsInCategoryStreamProviderElement(super.provider);

  @override
  String get id => (origin as ProductsInCategoryStreamProvider).id;
}

String _$productFutureHash() => r'59e38e74159692b0215458b7adf2d9594ac460bc';

/// See also [productFuture].
@ProviderFor(productFuture)
const productFutureProvider = ProductFutureFamily();

/// See also [productFuture].
class ProductFutureFamily extends Family<AsyncValue<Product?>> {
  /// See also [productFuture].
  const ProductFutureFamily();

  /// See also [productFuture].
  ProductFutureProvider call(String id) {
    return ProductFutureProvider(id);
  }

  @override
  ProductFutureProvider getProviderOverride(
    covariant ProductFutureProvider provider,
  ) {
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
  String? get name => r'productFutureProvider';
}

/// See also [productFuture].
class ProductFutureProvider extends AutoDisposeFutureProvider<Product?> {
  /// See also [productFuture].
  ProductFutureProvider(String id)
    : this._internal(
        (ref) => productFuture(ref as ProductFutureRef, id),
        from: productFutureProvider,
        name: r'productFutureProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productFutureHash,
        dependencies: ProductFutureFamily._dependencies,
        allTransitiveDependencies:
            ProductFutureFamily._allTransitiveDependencies,
        id: id,
      );

  ProductFutureProvider._internal(
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
  Override overrideWith(
    FutureOr<Product?> Function(ProductFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductFutureProvider._internal(
        (ref) => create(ref as ProductFutureRef),
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
  AutoDisposeFutureProviderElement<Product?> createElement() {
    return _ProductFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductFutureProvider && other.id == id;
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
mixin ProductFutureRef on AutoDisposeFutureProviderRef<Product?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductFutureProviderElement
    extends AutoDisposeFutureProviderElement<Product?>
    with ProductFutureRef {
  _ProductFutureProviderElement(super.provider);

  @override
  String get id => (origin as ProductFutureProvider).id;
}

String _$productStreamHash() => r'a1b468bcbc42b7c8e9a8989f913d1582c50af9aa';

/// See also [productStream].
@ProviderFor(productStream)
const productStreamProvider = ProductStreamFamily();

/// See also [productStream].
class ProductStreamFamily extends Family<AsyncValue<Product?>> {
  /// See also [productStream].
  const ProductStreamFamily();

  /// See also [productStream].
  ProductStreamProvider call(String id) {
    return ProductStreamProvider(id);
  }

  @override
  ProductStreamProvider getProviderOverride(
    covariant ProductStreamProvider provider,
  ) {
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
  String? get name => r'productStreamProvider';
}

/// See also [productStream].
class ProductStreamProvider extends AutoDisposeStreamProvider<Product?> {
  /// See also [productStream].
  ProductStreamProvider(String id)
    : this._internal(
        (ref) => productStream(ref as ProductStreamRef, id),
        from: productStreamProvider,
        name: r'productStreamProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productStreamHash,
        dependencies: ProductStreamFamily._dependencies,
        allTransitiveDependencies:
            ProductStreamFamily._allTransitiveDependencies,
        id: id,
      );

  ProductStreamProvider._internal(
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
  Override overrideWith(
    Stream<Product?> Function(ProductStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductStreamProvider._internal(
        (ref) => create(ref as ProductStreamRef),
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
  AutoDisposeStreamProviderElement<Product?> createElement() {
    return _ProductStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductStreamProvider && other.id == id;
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
mixin ProductStreamRef on AutoDisposeStreamProviderRef<Product?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductStreamProviderElement
    extends AutoDisposeStreamProviderElement<Product?>
    with ProductStreamRef {
  _ProductStreamProviderElement(super.provider);

  @override
  String get id => (origin as ProductStreamProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
