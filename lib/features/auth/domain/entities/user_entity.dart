class UserEntity {
  final int? id;       // optional, because login API doesn’t return it
  final String? name;  // optional
  final String? email; // optional
  final String token;  // required, login always returns this

  UserEntity({
    this.id,
    this.name,
    this.email,
    required this.token,
  });
}
