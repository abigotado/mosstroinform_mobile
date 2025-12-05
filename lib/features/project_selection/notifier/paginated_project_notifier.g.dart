// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_project_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier для управления списком проектов с пагинацией

@ProviderFor(PaginatedProjectsNotifier)
const paginatedProjectsProvider = PaginatedProjectsNotifierProvider._();

/// Notifier для управления списком проектов с пагинацией
final class PaginatedProjectsNotifierProvider
    extends
        $AsyncNotifierProvider<
          PaginatedProjectsNotifier,
          PaginatedProjectsState
        > {
  /// Notifier для управления списком проектов с пагинацией
  const PaginatedProjectsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paginatedProjectsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paginatedProjectsNotifierHash();

  @$internal
  @override
  PaginatedProjectsNotifier create() => PaginatedProjectsNotifier();
}

String _$paginatedProjectsNotifierHash() =>
    r'893cf6eff1e572a31bbdd8f3f5048c9a8387815e';

/// Notifier для управления списком проектов с пагинацией

abstract class _$PaginatedProjectsNotifier
    extends $AsyncNotifier<PaginatedProjectsState> {
  FutureOr<PaginatedProjectsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<PaginatedProjectsState>, PaginatedProjectsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PaginatedProjectsState>,
                PaginatedProjectsState
              >,
              AsyncValue<PaginatedProjectsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
