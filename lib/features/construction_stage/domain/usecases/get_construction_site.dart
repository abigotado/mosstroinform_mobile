import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/entities/construction_site.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/repositories/construction_site_repository.dart';

/// Use case для получения информации о строительной площадке
class GetConstructionSite {
  final ConstructionSiteRepository repository;

  GetConstructionSite(this.repository);

  Future<ConstructionSite> call(String projectId) async {
    try {
      return await repository.getConstructionSiteByProjectId(projectId);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении информации о стройке: $e');
    }
  }
}

