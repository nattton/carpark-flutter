class UserModel {
  final int id;
  final String username;
  final String role;

  const UserModel({
    required this.id,
    required this.username,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'username': String username,
        'role': String role,
      } =>
        UserModel(id: id, username: username, role: role),
      _ => throw const FormatException(),
    };
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'role': role,
      };
}
