/// Сущность пользователя в домене
class User {
  final String id;
  final String email;
  final String name;
  final String? phone;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
  });
}

