import 'package:freezed_annotation/freezed_annotation.dart';

part 'debug_info_entity.freezed.dart';

@freezed
sealed class DebugInfoEntity with _$DebugInfoEntity {
  const DebugInfoEntity._();
  const factory DebugInfoEntity.data({
    required String appVersion,
    required String appBuildNumber,
    required String flavor,
    required String? deviceModel,
    required String deviceOS,
  }) = DebugInfoEntityData;
  const factory DebugInfoEntity.loading() = DebugInfoEntityLoading;
  const factory DebugInfoEntity.error(String errorMessage) = DebugInfoEntityError;
}
