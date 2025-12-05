import 'package:mosstroinform_mobile/core/utils/extensions/error_guard_extension.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/models/construction_object_model.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/datasources/construction_object_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/construction_object.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/construction_object_repository.dart';

/// Реализация репозитория объектов строительства
class ConstructionObjectRepositoryImpl
    implements ConstructionObjectRepository {
  final IConstructionObjectRemoteDataSource remoteDataSource;

  ConstructionObjectRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ConstructionObject>> getObjects() async {
    return guard(() async {
      final models = await remoteDataSource.getObjects();
      return models.map((model) => model.toEntity()).toList();
    }, methodName: 'getObjects');
  }

  @override
  Future<ConstructionObject> getObjectById(String id) async {
    return guard(() async {
      final model = await remoteDataSource.getObjectById(id);
      return model.toEntity();
    }, methodName: 'getObjectById');
  }

  @override
  Future<List<ConstructionObject>> getRequestedObjects() async {
    return guard(() async {
      // Получаем все объекты и фильтруем по статусу этапов
      final allObjects = await getObjects();
      return allObjects
          .where((obj) => obj.stages
              .any((stage) => stage.status == StageStatus.inProgress))
          .toList();
    }, methodName: 'getRequestedObjects');
  }

  @override
  Future<List<ConstructionObject>> getCompletedObjects() async {
    return guard(() async {
      // Получаем все объекты и фильтруем по статусу этапов
      final allObjects = await getObjects();
      return allObjects
          .where((obj) =>
              obj.stages.isNotEmpty &&
              obj.stages.every((stage) => stage.status == StageStatus.completed))
          .toList();
    }, methodName: 'getCompletedObjects');
  }

  @override
  Future<void> completeConstruction(String objectId) async {
    return guard(() async {
      await remoteDataSource.completeConstruction(objectId);
    }, methodName: 'completeConstruction');
  }

  @override
  Future<void> updateDocumentsSignedStatus(
    String projectId,
    bool allDocumentsSigned,
  ) async {
    return guard(() async {
      await remoteDataSource.updateDocumentsSignedStatus(
        projectId,
        {'allDocumentsSigned': allDocumentsSigned},
      );
    }, methodName: 'updateDocumentsSignedStatus');
  }
}

