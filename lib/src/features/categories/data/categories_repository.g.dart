// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoriesRepositoryHash() =>
    r'c6c2b7ee76404cc4534bace6729e1d3ca4a892d4';

/// See also [categoriesRepository].
@ProviderFor(categoriesRepository)
final categoriesRepositoryProvider = Provider<CategoriesRepository>.internal(
  categoriesRepository,
  name: r'categoriesRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$categoriesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoriesRepositoryRef = ProviderRef<CategoriesRepository>;
String _$categoriesFutureHash() => r'a1d42174f88b78897adba0cbe17024e1cdc17e32';

/// See also [categoriesFuture].
@ProviderFor(categoriesFuture)
final categoriesFutureProvider =
    AutoDisposeFutureProvider<List<Category>>.internal(
      categoriesFuture,
      name: r'categoriesFutureProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$categoriesFutureHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoriesFutureRef = AutoDisposeFutureProviderRef<List<Category>>;
String _$categoryFutureHash() => r'1fca796d3b26c30526cb09260fe9b0a13b84988a';

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

/// See also [categoryFuture].
@ProviderFor(categoryFuture)
const categoryFutureProvider = CategoryFutureFamily();

/// See also [categoryFuture].
class CategoryFutureFamily extends Family<AsyncValue<Category?>> {
  /// See also [categoryFuture].
  const CategoryFutureFamily();

  /// See also [categoryFuture].
  CategoryFutureProvider call(String id) {
    return CategoryFutureProvider(id);
  }

  @override
  CategoryFutureProvider getProviderOverride(
    covariant CategoryFutureProvider provider,
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
  String? get name => r'categoryFutureProvider';
}

/// See also [categoryFuture].
class CategoryFutureProvider extends AutoDisposeFutureProvider<Category?> {
  /// See also [categoryFuture].
  CategoryFutureProvider(String id)
    : this._internal(
        (ref) => categoryFuture(ref as CategoryFutureRef, id),
        from: categoryFutureProvider,
        name: r'categoryFutureProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$categoryFutureHash,
        dependencies: CategoryFutureFamily._dependencies,
        allTransitiveDependencies:
            CategoryFutureFamily._allTransitiveDependencies,
        id: id,
      );

  CategoryFutureProvider._internal(
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
    FutureOr<Category?> Function(CategoryFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategoryFutureProvider._internal(
        (ref) => create(ref as CategoryFutureRef),
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
  AutoDisposeFutureProviderElement<Category?> createElement() {
    return _CategoryFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryFutureProvider && other.id == id;
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
mixin CategoryFutureRef on AutoDisposeFutureProviderRef<Category?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CategoryFutureProviderElement
    extends AutoDisposeFutureProviderElement<Category?>
    with CategoryFutureRef {
  _CategoryFutureProviderElement(super.provider);

  @override
  String get id => (origin as CategoryFutureProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
