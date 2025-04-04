// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_sequences_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productSequencesRepositoryHash() =>
    r'2ce09f6b3849d01ceec0458e481e0f30513eaaba';

/// See also [productSequencesRepository].
@ProviderFor(productSequencesRepository)
final productSequencesRepositoryProvider =
    Provider<ProductSequencesRepository>.internal(
      productSequencesRepository,
      name: r'productSequencesRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$productSequencesRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductSequencesRepositoryRef = ProviderRef<ProductSequencesRepository>;
String _$productSequenceInCategoryHash() =>
    r'6072ed78f5e42b229a17eb768f48eb20adf70979';

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

/// See also [productSequenceInCategory].
@ProviderFor(productSequenceInCategory)
const productSequenceInCategoryProvider = ProductSequenceInCategoryFamily();

/// See also [productSequenceInCategory].
class ProductSequenceInCategoryFamily extends Family<AsyncValue<List<String>>> {
  /// See also [productSequenceInCategory].
  const ProductSequenceInCategoryFamily();

  /// See also [productSequenceInCategory].
  ProductSequenceInCategoryProvider call(String categoryId) {
    return ProductSequenceInCategoryProvider(categoryId);
  }

  @override
  ProductSequenceInCategoryProvider getProviderOverride(
    covariant ProductSequenceInCategoryProvider provider,
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
  String? get name => r'productSequenceInCategoryProvider';
}

/// See also [productSequenceInCategory].
class ProductSequenceInCategoryProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [productSequenceInCategory].
  ProductSequenceInCategoryProvider(String categoryId)
    : this._internal(
        (ref) => productSequenceInCategory(
          ref as ProductSequenceInCategoryRef,
          categoryId,
        ),
        from: productSequenceInCategoryProvider,
        name: r'productSequenceInCategoryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productSequenceInCategoryHash,
        dependencies: ProductSequenceInCategoryFamily._dependencies,
        allTransitiveDependencies:
            ProductSequenceInCategoryFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  ProductSequenceInCategoryProvider._internal(
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
    FutureOr<List<String>> Function(ProductSequenceInCategoryRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductSequenceInCategoryProvider._internal(
        (ref) => create(ref as ProductSequenceInCategoryRef),
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
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _ProductSequenceInCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductSequenceInCategoryProvider &&
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
mixin ProductSequenceInCategoryRef
    on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `categoryId` of this provider.
  String get categoryId;
}

class _ProductSequenceInCategoryProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with ProductSequenceInCategoryRef {
  _ProductSequenceInCategoryProviderElement(super.provider);

  @override
  String get categoryId =>
      (origin as ProductSequenceInCategoryProvider).categoryId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
