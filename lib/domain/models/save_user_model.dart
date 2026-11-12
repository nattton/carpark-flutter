import 'package:json_annotation/json_annotation.dart';

part 'save_user_model.g.dart';

@JsonSerializable()
class SaveUserModel {
  new({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$SaveUserModelFromJson(json);
  final int id;
  final String username;
  final String password;
  final String role;

  Map<String, dynamic> toJson() => _$SaveUserModelToJson(this);
}
