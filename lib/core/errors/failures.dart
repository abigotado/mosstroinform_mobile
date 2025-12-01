/// Базовый класс для ошибок
abstract class Failure {
  const Failure(this.message);

  final String message;
}

/// Ошибка сети
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Ошибка сервера
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Ошибка кэша
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Ошибка валидации
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Неизвестная ошибка
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

