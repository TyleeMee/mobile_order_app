// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$validOwnerIdHash() => r'cbafe09c8cf726cba4859e0284dbc7de0138f0e3';

/// See also [validOwnerId].
@ProviderFor(validOwnerId)
final validOwnerIdProvider = FutureProvider<String>.internal(
  validOwnerId,
  name: r'validOwnerIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$validOwnerIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ValidOwnerIdRef = FutureProviderRef<String>;
String _$appConfigNotifierHash() => r'd517721a7443d924fc0004a237bb34a0dc7e415a';

/// See also [AppConfigNotifier].
@ProviderFor(AppConfigNotifier)
final appConfigNotifierProvider =
    NotifierProvider<AppConfigNotifier, AppConfig>.internal(
      AppConfigNotifier.new,
      name: r'appConfigNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$appConfigNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppConfigNotifier = Notifier<AppConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
