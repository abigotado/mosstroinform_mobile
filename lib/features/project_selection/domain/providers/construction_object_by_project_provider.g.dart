// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_object_by_project_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для получения объекта строительства по projectId

@ProviderFor(constructionObjectByProject)
const constructionObjectByProjectProvider =
    ConstructionObjectByProjectFamily._();

/// Провайдер для получения объекта строительства по projectId

final class ConstructionObjectByProjectProvider
    extends
        $FunctionalProvider<
          AsyncValue<ConstructionObject>,
          ConstructionObject,
          FutureOr<ConstructionObject>
        >
    with
        $FutureModifier<ConstructionObject>,
        $FutureProvider<ConstructionObject> {
  /// Провайдер для получения объекта строительства по projectId
  const ConstructionObjectByProjectProvider._({
    required ConstructionObjectByProjectFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'constructionObjectByProjectProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$constructionObjectByProjectHash();

  @override
  String toString() {
    return r'constructionObjectByProjectProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ConstructionObject> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ConstructionObject> create(Ref ref) {
    final argument = this.argument as String;
    return constructionObjectByProject(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ConstructionObjectByProjectProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$constructionObjectByProjectHash() =>
    r'43f54b907afffe1b8d7184dfa4b64477a3bf07c5';

/// Провайдер для получения объекта строительства по projectId

final class ConstructionObjectByProjectFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ConstructionObject>, String> {
  const ConstructionObjectByProjectFamily._()
    : super(
        retry: null,
        name: r'constructionObjectByProjectProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Провайдер для получения объекта строительства по projectId

  ConstructionObjectByProjectProvider call(String projectId) =>
      ConstructionObjectByProjectProvider._(argument: projectId, from: this);

  @override
  String toString() => r'constructionObjectByProjectProvider';
}
