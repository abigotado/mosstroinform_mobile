import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/entities/construction_site.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/repositories/construction_site_repository.dart';

/// Use case для получения списка камер
class GetCameras {
  final ConstructionSiteRepository repository;

  GetCameras(this.repository);

  Future<List<Camera>> call(String siteId) async {
    try {
      return await repository.getCameras(siteId);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении списка камер: $e');
    }
  }
}
