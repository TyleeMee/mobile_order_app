// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_sequences_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productSequencesRepositoryHash() =>
    r'fcd22393e3dbfaa8bbdf87d0c2debfbd12fc603a';

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
String _$productSequenceInCategoryFutureHash() =>
    r'49c4074bedf21663b83b7a8bf6567fd58c31064c';

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

/// See also [productSequenceInCategoryFuture].
@ProviderFor(productSequenceInCategoryFuture)
const productSequenceInCategoryFutureProvider =
    ProductSequenceInCategoryFutureFamily();

/// See also [productSequenceInCategoryFuture].
class ProductSequenceInCategoryFutureFamily
    extends Family<AsyncValue<List<String>>> {
  /// See also [productSequenceInCategoryFuture].
  const ProductSequenceInCategoryFutureFamily();

  /// See also [productSequenceInCategoryFuture].
  ProductSequenceInCategoryFutureProvider call(String categoryId) {
    return ProductSequenceInCategoryFutureProvider(categoryId);
  }

  @override
  ProductSequenceInCategoryFutureProvider getProviderOverride(
    covariant ProductSequenceInCategoryFutureProvider provider,
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
  String? get name => r'productSequenceInCategoryFutureProvider';
}

/// See also [productSequenceInCategoryFuture].
class ProductSequenceInCategoryFutureProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [productSequenceInCategoryFuture].
  ProductSequenceInCategoryFutureProvider(String categoryId)
    : this._internal(
        (ref) => productSequenceInCategoryFuture(
          ref as ProductSequenceInCategoryFutureRef,
          categoryId,
        ),
        from: productSequenceInCategoryFutureProvider,
        name: r'productSequenceInCategoryFutureProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productSequenceInCategoryFutureHash,
        dependencies: ProductSequenceInCategoryFutureFamily._dependencies,
        allTransitiveDependencies:
            ProductSequenceInCategoryFutureFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  ProductSequenceInCategoryFutureProvider._internal(
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
    FutureOr<List<String>> Function(ProductSequenceInCategoryFutureRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductSequenceInCategoryFutureProvider._internal(
        (ref) => create(ref as ProductSequenceInCategoryFutureRef),
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
    return _ProductSequenceInCategoryFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductSequenceInCategoryFutureProvider &&
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
mixin ProductSequenceInCategoryFutureRef
    on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `categoryId` of this provider.
  String get categoryId;
}

class _ProductSequenceInCategoryFutureProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with ProductSequenceInCategoryFutureRef {
  _ProductSequenceInCategoryFutureProviderElement(super.provider);

  @override
  String get categoryId =>
      (origin as ProductSequenceInCategoryFutureProvider).categoryId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
