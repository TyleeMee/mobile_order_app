// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsServiceHash() => r'182036edadc2ce6e03919b45ae0265ca41a04976';

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
String _$productsInCategoryHash() =>
    r'02b37ec27458ffa4308da7150f0f431f4643a8f4';

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

/// カテゴリ内の商品を取得するProvider
///
/// Copied from [productsInCategory].
@ProviderFor(productsInCategory)
const productsInCategoryProvider = ProductsInCategoryFamily();

/// カテゴリ内の商品を取得するProvider
///
/// Copied from [productsInCategory].
class ProductsInCategoryFamily extends Family<AsyncValue<List<Product>>> {
  /// カテゴリ内の商品を取得するProvider
  ///
  /// Copied from [productsInCategory].
  const ProductsInCategoryFamily();

  /// カテゴリ内の商品を取得するProvider
  ///
  /// Copied from [productsInCategory].
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

/// カテゴリ内の商品を取得するProvider
///
/// Copied from [productsInCategory].
class ProductsInCategoryProvider
    extends AutoDisposeFutureProvider<List<Product>> {
  /// カテゴリ内の商品を取得するProvider
  ///
  /// Copied from [productsInCategory].
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

String _$productHash() => r'16a90dd0459606875cbcc24541e9f3f19407ca73';

/// 特定の商品を取得するProvider（改良版）
///
/// Copied from [product].
@ProviderFor(product)
const productProvider = ProductFamily();

/// 特定の商品を取得するProvider（改良版）
///
/// Copied from [product].
class ProductFamily extends Family<AsyncValue<Product?>> {
  /// 特定の商品を取得するProvider（改良版）
  ///
  /// Copied from [product].
  const ProductFamily();

  /// 特定の商品を取得するProvider（改良版）
  ///
  /// Copied from [product].
  ProductProvider call(String id) {
    return ProductProvider(id);
  }

  @override
  ProductProvider getProviderOverride(covariant ProductProvider provider) {
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
  String? get name => r'productProvider';
}

/// 特定の商品を取得するProvider（改良版）
///
/// Copied from [product].
class ProductProvider extends AutoDisposeFutureProvider<Product?> {
  /// 特定の商品を取得するProvider（改良版）
  ///
  /// Copied from [product].
  ProductProvider(String id)
    : this._internal(
        (ref) => product(ref as ProductRef, id),
        from: productProvider,
        name: r'productProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productHash,
        dependencies: ProductFamily._dependencies,
        allTransitiveDependencies: ProductFamily._allTransitiveDependencies,
        id: id,
      );

  ProductProvider._internal(
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
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Product?> createElement() {
    return _ProductProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductProvider && other.id == id;
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
mixin ProductRef on AutoDisposeFutureProviderRef<Product?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductProviderElement extends AutoDisposeFutureProviderElement<Product?>
    with ProductRef {
  _ProductProviderElement(super.provider);

  @override
  String get id => (origin as ProductProvider).id;
}

String _$featuredProductsHash() => r'a77ce312eceee7dc9410dbfc31f218b051fbde3c';

/// おすすめ商品を取得するProvider
///
/// Copied from [featuredProducts].
@ProviderFor(featuredProducts)
const featuredProductsProvider = FeaturedProductsFamily();

/// おすすめ商品を取得するProvider
///
/// Copied from [featuredProducts].
class FeaturedProductsFamily extends Family<AsyncValue<List<Product>>> {
  /// おすすめ商品を取得するProvider
  ///
  /// Copied from [featuredProducts].
  const FeaturedProductsFamily();

  /// おすすめ商品を取得するProvider
  ///
  /// Copied from [featuredProducts].
  FeaturedProductsProvider call({int limit = 10}) {
    return FeaturedProductsProvider(limit: limit);
  }

  @override
  FeaturedProductsProvider getProviderOverride(
    covariant FeaturedProductsProvider provider,
  ) {
    return call(limit: provider.limit);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'featuredProductsProvider';
}

/// おすすめ商品を取得するProvider
///
/// Copied from [featuredProducts].
class FeaturedProductsProvider
    extends AutoDisposeFutureProvider<List<Product>> {
  /// おすすめ商品を取得するProvider
  ///
  /// Copied from [featuredProducts].
  FeaturedProductsProvider({int limit = 10})
    : this._internal(
        (ref) => featuredProducts(ref as FeaturedProductsRef, limit: limit),
        from: featuredProductsProvider,
        name: r'featuredProductsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$featuredProductsHash,
        dependencies: FeaturedProductsFamily._dependencies,
        allTransitiveDependencies:
            FeaturedProductsFamily._allTransitiveDependencies,
        limit: limit,
      );

  FeaturedProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
  }) : super.internal();

  final int limit;

  @override
  Override overrideWith(
    FutureOr<List<Product>> Function(FeaturedProductsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FeaturedProductsProvider._internal(
        (ref) => create(ref as FeaturedProductsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Product>> createElement() {
    return _FeaturedProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FeaturedProductsProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FeaturedProductsRef on AutoDisposeFutureProviderRef<List<Product>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _FeaturedProductsProviderElement
    extends AutoDisposeFutureProviderElement<List<Product>>
    with FeaturedProductsRef {
  _FeaturedProductsProviderElement(super.provider);

  @override
  int get limit => (origin as FeaturedProductsProvider).limit;
}

String _$searchProductsHash() => r'd6735d7c724e2b3eaaf5f21e2a650e6fdf67ad94';

/// 商品検索Provider
///
/// Copied from [searchProducts].
@ProviderFor(searchProducts)
const searchProductsProvider = SearchProductsFamily();

/// 商品検索Provider
///
/// Copied from [searchProducts].
class SearchProductsFamily extends Family<AsyncValue<List<Product>>> {
  /// 商品検索Provider
  ///
  /// Copied from [searchProducts].
  const SearchProductsFamily();

  /// 商品検索Provider
  ///
  /// Copied from [searchProducts].
  SearchProductsProvider call(String keyword) {
    return SearchProductsProvider(keyword);
  }

  @override
  SearchProductsProvider getProviderOverride(
    covariant SearchProductsProvider provider,
  ) {
    return call(provider.keyword);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchProductsProvider';
}

/// 商品検索Provider
///
/// Copied from [searchProducts].
class SearchProductsProvider extends AutoDisposeFutureProvider<List<Product>> {
  /// 商品検索Provider
  ///
  /// Copied from [searchProducts].
  SearchProductsProvider(String keyword)
    : this._internal(
        (ref) => searchProducts(ref as SearchProductsRef, keyword),
        from: searchProductsProvider,
        name: r'searchProductsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$searchProductsHash,
        dependencies: SearchProductsFamily._dependencies,
        allTransitiveDependencies:
            SearchProductsFamily._allTransitiveDependencies,
        keyword: keyword,
      );

  SearchProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.keyword,
  }) : super.internal();

  final String keyword;

  @override
  Override overrideWith(
    FutureOr<List<Product>> Function(SearchProductsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchProductsProvider._internal(
        (ref) => create(ref as SearchProductsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        keyword: keyword,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Product>> createElement() {
    return _SearchProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchProductsProvider && other.keyword == keyword;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, keyword.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchProductsRef on AutoDisposeFutureProviderRef<List<Product>> {
  /// The parameter `keyword` of this provider.
  String get keyword;
}

class _SearchProductsProviderElement
    extends AutoDisposeFutureProviderElement<List<Product>>
    with SearchProductsRef {
  _SearchProductsProviderElement(super.provider);

  @override
  String get keyword => (origin as SearchProductsProvider).keyword;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
