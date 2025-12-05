import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/construction_object.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/construction_object_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'construction_object_by_project_provider.g.dart';

/// Провайдер для получения объекта строительства по projectId
@riverpod
Future<ConstructionObject> constructionObjectByProject(
  Ref ref,
  String projectId,
) async {
  final objectRepository = ref.read(constructionObjectRepositoryProvider);
  final objects = await objectRepository.getObjects();
  return objects.firstWhere(
    (obj) => obj.projectId == projectId,
    orElse: () => throw UnknownFailure('Объект не найден'),
  );
}

