// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoriesHash() => r'29c590a8a8da416a08bc11adfcda85edfe9404ae';

/// See also [categories].
@ProviderFor(categories)
final categoriesProvider = AutoDisposeFutureProvider<List<Category>>.internal(
  categories,
  name: r'categoriesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$categoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoriesRef = AutoDisposeFutureProviderRef<List<Category>>;
String _$categoryHash() => r'5b59f5443b5603696c34f38750f6aa6d22bff2d2';

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

/// See also [category].
@ProviderFor(category)
const categoryProvider = CategoryFamily();

/// See also [category].
class CategoryFamily extends Family<AsyncValue<Category?>> {
  /// See also [category].
  const CategoryFamily();

  /// See also [category].
  CategoryProvider call(String categoryId) {
    return CategoryProvider(categoryId);
  }

  @override
  CategoryProvider getProviderOverride(covariant CategoryProvider provider) {
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
  String? get name => r'categoryProvider';
}

/// See also [category].
class CategoryProvider extends AutoDisposeFutureProvider<Category?> {
  /// See also [category].
  CategoryProvider(String categoryId)
    : this._internal(
        (ref) => category(ref as CategoryRef, categoryId),
        from: categoryProvider,
        name: r'categoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$categoryHash,
        dependencies: CategoryFamily._dependencies,
        allTransitiveDependencies: CategoryFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  CategoryProvider._internal(
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
    FutureOr<Category?> Function(CategoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategoryProvider._internal(
        (ref) => create(ref as CategoryRef),
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
  AutoDisposeFutureProviderElement<Category?> createElement() {
    return _CategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryProvider && other.categoryId == categoryId;
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
mixin CategoryRef on AutoDisposeFutureProviderRef<Category?> {
  /// The parameter `categoryId` of this provider.
  String get categoryId;
}

class _CategoryProviderElement
    extends AutoDisposeFutureProviderElement<Category?>
    with CategoryRef {
  _CategoryProviderElement(super.provider);

  @override
  String get categoryId => (origin as CategoryProvider).categoryId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
