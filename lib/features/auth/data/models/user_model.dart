import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mosstroinform_mobile/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Модель пользователя для слоя данных
@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    String? phone,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// Расширение для конвертации модели в сущность
extension UserModelX on UserModel {
  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      phone: phone,
    );
  }
}

