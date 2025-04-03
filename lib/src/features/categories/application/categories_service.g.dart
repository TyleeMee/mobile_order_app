// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoriesServiceHash() => r'832b0631c1de8486a1a31412b2d4dc2f87fb68ac';

/// See also [categoriesService].
@ProviderFor(categoriesService)
final categoriesServiceProvider = Provider<CategoriesService>.internal(
  categoriesService,
  name: r'categoriesServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$categoriesServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoriesServiceRef = ProviderRef<CategoriesService>;
String _$sortedCategoriesFutureHash() =>
    r'f5ba650ab52e03c9613b6df2b22e7d417794175c';

/// See also [sortedCategoriesFuture].
@ProviderFor(sortedCategoriesFuture)
final sortedCategoriesFutureProvider =
    AutoDisposeFutureProvider<List<Category>>.internal(
      sortedCategoriesFuture,
      name: r'sortedCategoriesFutureProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$sortedCategoriesFutureHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SortedCategoriesFutureRef =
    AutoDisposeFutureProviderRef<List<Category>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
