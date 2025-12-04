import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mosstroinform_mobile/features/auth/data/models/user_model.dart';

part 'auth_remote_data_source.g.dart';

/// Интерфейс удалённого источника данных для авторизации
@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) =
      _AuthRemoteDataSource;

  /// Вход в систему
  @POST('/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  /// Регистрация нового пользователя
  @POST('/auth/register')
  Future<LoginResponse> register(@Body() RegisterRequest request);

  /// Получить текущего пользователя
  @GET('/auth/me')
  Future<UserModel> getCurrentUser();

  /// Обновить токен доступа
  @POST('/auth/refresh')
  Future<LoginResponse> refreshToken(@Body() RefreshTokenRequest request);
}

/// Запрос на вход
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

/// Запрос на регистрацию
class RegisterRequest {
  final String email;
  final String password;
  final String name;
  final String? phone;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        if (phone != null) 'phone': phone,
      };
}

/// Запрос на обновление токена
class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  Map<String, dynamic> toJson() => {
        'refresh_token': refreshToken,
      };
}

/// Ответ с токенами
class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

