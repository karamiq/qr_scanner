// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getQRDataHistoryHash() => r'60fba9eec4fde4aae307f2b588d14a4de3664044';

/// See also [getQRDataHistory].
@ProviderFor(getQRDataHistory)
final getQRDataHistoryProvider =
    AutoDisposeStreamProvider<List<QrDataModel>>.internal(
  getQRDataHistory,
  name: r'getQRDataHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getQRDataHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetQRDataHistoryRef = AutoDisposeStreamProviderRef<List<QrDataModel>>;
String _$addQRDataHash() => r'dca2bb437f2cf5da90cbc85b1abd8df45cf3674b';

/// See also [AddQRData].
@ProviderFor(AddQRData)
final addQRDataProvider =
    AutoDisposeAsyncNotifierProvider<AddQRData, AsyncX<QrDataModel>>.internal(
  AddQRData.new,
  name: r'addQRDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$addQRDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AddQRData = AutoDisposeAsyncNotifier<AsyncX<QrDataModel>>;
String _$deleteQRDataProviderHash() =>
    r'65acd713c433326c0c495bec6e77f6d3b3aca077';

/// See also [DeleteQRDataProvider].
@ProviderFor(DeleteQRDataProvider)
final deleteQRDataProviderProvider = AutoDisposeAsyncNotifierProvider<
    DeleteQRDataProvider, AsyncX<void>>.internal(
  DeleteQRDataProvider.new,
  name: r'deleteQRDataProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteQRDataProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeleteQRDataProvider = AutoDisposeAsyncNotifier<AsyncX<void>>;
String _$deleteQRDataHash() => r'a5017d2d7df67d5e6fe8fb09a250e91102ca999c';

/// See also [DeleteQRData].
@ProviderFor(DeleteQRData)
final deleteQRDataProvider =
    AutoDisposeAsyncNotifierProvider<DeleteQRData, AsyncX<dynamic>>.internal(
  DeleteQRData.new,
  name: r'deleteQRDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$deleteQRDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeleteQRData = AutoDisposeAsyncNotifier<AsyncX<dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
