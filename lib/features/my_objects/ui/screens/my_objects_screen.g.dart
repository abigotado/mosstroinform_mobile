// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_objects_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для списка объектов строительства

@ProviderFor(myObjects)
const myObjectsProvider = MyObjectsProvider._();

/// Провайдер для списка объектов строительства

final class MyObjectsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ConstructionObject>>,
          List<ConstructionObject>,
          FutureOr<List<ConstructionObject>>
        >
    with
        $FutureModifier<List<ConstructionObject>>,
        $FutureProvider<List<ConstructionObject>> {
  /// Провайдер для списка объектов строительства
  const MyObjectsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myObjectsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myObjectsHash();

  @$internal
  @override
  $FutureProviderElement<List<ConstructionObject>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ConstructionObject>> create(Ref ref) {
    return myObjects(ref);
  }
}

String _$myObjectsHash() => r'59b7c1c8e4917f9b5f24704b83567df157ef8474';
