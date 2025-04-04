// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsServiceHash() => r'f72efd76f33b168ee205a874d328f5791c14ce47';

/// See also [productsService].
@ProviderFor(productsService)
final productsServiceProvider = Provider<ProductsService>.internal(
  productsService,
  name: r'productsServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$productsServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsServiceRef = ProviderRef<ProductsService>;
String _$sortedProductsInCategoryHash() =>
    r'00f6b183de478b6f8d386653ea372e4bc0ad2e4c';

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

/// See also [sortedProductsInCategory].
@ProviderFor(sortedProductsInCategory)
const sortedProductsInCategoryProvider = SortedProductsInCategoryFamily();

/// See also [sortedProductsInCategory].
class SortedProductsInCategoryFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [sortedProductsInCategory].
  const SortedProductsInCategoryFamily();

  /// See also [sortedProductsInCategory].
  SortedProductsInCategoryProvider call(String categoryId) {
    return SortedProductsInCategoryProvider(categoryId);
  }

  @override
  SortedProductsInCategoryProvider getProviderOverride(
    covariant SortedProductsInCategoryProvider provider,
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
  String? get name => r'sortedProductsInCategoryProvider';
}

/// See also [sortedProductsInCategory].
class SortedProductsInCategoryProvider
    extends AutoDisposeFutureProvider<List<Product>> {
  /// See also [sortedProductsInCategory].
  SortedProductsInCategoryProvider(String categoryId)
    : this._internal(
        (ref) => sortedProductsInCategory(
          ref as SortedProductsInCategoryRef,
          categoryId,
        ),
        from: sortedProductsInCategoryProvider,
        name: r'sortedProductsInCategoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$sortedProductsInCategoryHash,
        dependencies: SortedProductsInCategoryFamily._dependencies,
        allTransitiveDependencies:
            SortedProductsInCategoryFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  SortedProductsInCategoryProvider._internal(
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
    FutureOr<List<Product>> Function(SortedProductsInCategoryRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SortedProductsInCategoryProvider._internal(
        (ref) => create(ref as SortedProductsInCategoryRef),
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
    return _SortedProductsInCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SortedProductsInCategoryProvider &&
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
mixin SortedProductsInCategoryRef
    on AutoDisposeFutureProviderRef<List<Product>> {
  /// The parameter `categoryId` of this provider.
  String get categoryId;
}

class _SortedProductsInCategoryProviderElement
    extends AutoDisposeFutureProviderElement<List<Product>>
    with SortedProductsInCategoryRef {
  _SortedProductsInCategoryProviderElement(super.provider);

  @override
  String get categoryId =>
      (origin as SortedProductsInCategoryProvider).categoryId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
