import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/entities/construction_site.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/repositories/construction_site_repository.dart';

/// Use case для получения информации о конкретной камере
class GetCameraById {
  final ConstructionSiteRepository repository;

  GetCameraById(this.repository);

  Future<Camera> call(String siteId, String cameraId) async {
    try {
      return await repository.getCameraById(siteId, cameraId);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении информации о камере: $e');
    }
  }
}
