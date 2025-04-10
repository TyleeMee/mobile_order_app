// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_formatter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dateWithYearHash() => r'9f5a23d6c4af347ca2938ccf390404f85a6f57d0';

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

/// See also [dateWithYear].
@ProviderFor(dateWithYear)
const dateWithYearProvider = DateWithYearFamily();

/// See also [dateWithYear].
class DateWithYearFamily extends Family<String> {
  /// See also [dateWithYear].
  const DateWithYearFamily();

  /// See also [dateWithYear].
  DateWithYearProvider call(DateTime date) {
    return DateWithYearProvider(date);
  }

  @override
  DateWithYearProvider getProviderOverride(
    covariant DateWithYearProvider provider,
  ) {
    return call(provider.date);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dateWithYearProvider';
}

/// See also [dateWithYear].
class DateWithYearProvider extends AutoDisposeProvider<String> {
  /// See also [dateWithYear].
  DateWithYearProvider(DateTime date)
    : this._internal(
        (ref) => dateWithYear(ref as DateWithYearRef, date),
        from: dateWithYearProvider,
        name: r'dateWithYearProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$dateWithYearHash,
        dependencies: DateWithYearFamily._dependencies,
        allTransitiveDependencies:
            DateWithYearFamily._allTransitiveDependencies,
        date: date,
      );

  DateWithYearProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(String Function(DateWithYearRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: DateWithYearProvider._internal(
        (ref) => create(ref as DateWithYearRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _DateWithYearProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DateWithYearProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DateWithYearRef on AutoDisposeProviderRef<String> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _DateWithYearProviderElement extends AutoDisposeProviderElement<String>
    with DateWithYearRef {
  _DateWithYearProviderElement(super.provider);

  @override
  DateTime get date => (origin as DateWithYearProvider).date;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
