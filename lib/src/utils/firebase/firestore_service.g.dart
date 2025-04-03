// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firestoreServiceHash() => r'64bb5d50049dc65279aa722f222743756f003e68';

/// See also [firestoreService].
@ProviderFor(firestoreService)
final firestoreServiceProvider = Provider<FirestoreService>.internal(
  firestoreService,
  name: r'firestoreServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$firestoreServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirestoreServiceRef = ProviderRef<FirestoreService>;
String _$customFirestoreServiceHash() =>
    r'76d3fa8e94203d97552954f30e3b94e8cdde5306';

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

/// See also [customFirestoreService].
@ProviderFor(customFirestoreService)
const customFirestoreServiceProvider = CustomFirestoreServiceFamily();

/// See also [customFirestoreService].
class CustomFirestoreServiceFamily extends Family<FirestoreService> {
  /// See also [customFirestoreService].
  const CustomFirestoreServiceFamily();

  /// See also [customFirestoreService].
  CustomFirestoreServiceProvider call(FirestoreServiceOptions options) {
    return CustomFirestoreServiceProvider(options);
  }

  @override
  CustomFirestoreServiceProvider getProviderOverride(
    covariant CustomFirestoreServiceProvider provider,
  ) {
    return call(provider.options);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'customFirestoreServiceProvider';
}

/// See also [customFirestoreService].
class CustomFirestoreServiceProvider
    extends AutoDisposeProvider<FirestoreService> {
  /// See also [customFirestoreService].
  CustomFirestoreServiceProvider(FirestoreServiceOptions options)
    : this._internal(
        (ref) =>
            customFirestoreService(ref as CustomFirestoreServiceRef, options),
        from: customFirestoreServiceProvider,
        name: r'customFirestoreServiceProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$customFirestoreServiceHash,
        dependencies: CustomFirestoreServiceFamily._dependencies,
        allTransitiveDependencies:
            CustomFirestoreServiceFamily._allTransitiveDependencies,
        options: options,
      );

  CustomFirestoreServiceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.options,
  }) : super.internal();

  final FirestoreServiceOptions options;

  @override
  Override overrideWith(
    FirestoreService Function(CustomFirestoreServiceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CustomFirestoreServiceProvider._internal(
        (ref) => create(ref as CustomFirestoreServiceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        options: options,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<FirestoreService> createElement() {
    return _CustomFirestoreServiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomFirestoreServiceProvider && other.options == options;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, options.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CustomFirestoreServiceRef on AutoDisposeProviderRef<FirestoreService> {
  /// The parameter `options` of this provider.
  FirestoreServiceOptions get options;
}

class _CustomFirestoreServiceProviderElement
    extends AutoDisposeProviderElement<FirestoreService>
    with CustomFirestoreServiceRef {
  _CustomFirestoreServiceProviderElement(super.provider);

  @override
  FirestoreServiceOptions get options =>
      (origin as CustomFirestoreServiceProvider).options;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
