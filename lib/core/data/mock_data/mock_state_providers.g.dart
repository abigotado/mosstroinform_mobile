// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_state_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mockDocumentsStateHash() =>
    r'4628894770df3e6b777a57b38922cfb932479559';

/// Провайдер состояния моковых документов
/// Состояние хранится в памяти и сбрасывается при перезапуске приложения
///
/// Copied from [MockDocumentsState].
@ProviderFor(MockDocumentsState)
final mockDocumentsStateProvider =
    NotifierProvider<MockDocumentsState, List<Document>>.internal(
      MockDocumentsState.new,
      name: r'mockDocumentsStateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$mockDocumentsStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MockDocumentsState = Notifier<List<Document>>;
String _$mockProjectsStateHash() => r'6ad6f218a4505b96a28ae47b8d534616fd8b7aa9';

/// Провайдер состояния моковых проектов
/// Состояние хранится в памяти и сбрасывается при перезапуске приложения
///
/// Copied from [MockProjectsState].
@ProviderFor(MockProjectsState)
final mockProjectsStateProvider =
    NotifierProvider<MockProjectsState, List<Project>>.internal(
      MockProjectsState.new,
      name: r'mockProjectsStateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$mockProjectsStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MockProjectsState = Notifier<List<Project>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
