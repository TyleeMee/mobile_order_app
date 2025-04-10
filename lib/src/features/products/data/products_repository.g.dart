// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsRepositoryHash() =>
    r'a0d3285386322013ec96d12856c6e86faf320281';

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
String _$productsInCategoryHash() =>
    r'967e99200fb0516a6c85f3d14636911a956471c0';

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

String _$productsByIdsHash() => r'dfdb4b181a362bbc824a0a0e83aaec5b4730286f';

///商品リストをProductIdsから取得
///
/// Copied from [productsByIds].
@ProviderFor(productsByIds)
const productsByIdsProvider = ProductsByIdsFamily();

///商品リストをProductIdsから取得
///
/// Copied from [productsByIds].
class ProductsByIdsFamily extends Family<AsyncValue<List<Product>>> {
  ///商品リストをProductIdsから取得
  ///
  /// Copied from [productsByIds].
  const ProductsByIdsFamily();

  ///商品リストをProductIdsから取得
  ///
  /// Copied from [productsByIds].
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

///商品リストをProductIdsから取得
///
/// Copied from [productsByIds].
class ProductsByIdsProvider extends AutoDisposeFutureProvider<List<Product>> {
  ///商品リストをProductIdsから取得
  ///
  /// Copied from [productsByIds].
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

String _$productHash() => r'269ec54c5a6bc5279964154c15cd0bb58c643270';

/// 特定の商品を取得するProvider
///
/// Copied from [product].
@ProviderFor(product)
const productProvider = ProductFamily();

/// 特定の商品を取得するProvider
///
/// Copied from [product].
class ProductFamily extends Family<AsyncValue<Product?>> {
  /// 特定の商品を取得するProvider
  ///
  /// Copied from [product].
  const ProductFamily();

  /// 特定の商品を取得するProvider
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

/// 特定の商品を取得するProvider
///
/// Copied from [product].
class ProductProvider extends AutoDisposeFutureProvider<Product?> {
  /// 特定の商品を取得するProvider
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

String _$featuredProductsHash() => r'81eec5dba25f120189d658d9ffb3d67ab9770eb9';

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

String _$searchProductsHash() => r'7059590a94f39796352fdf39d9b15ff6ff84f86e';

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
