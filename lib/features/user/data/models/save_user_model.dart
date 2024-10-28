import 'package:json_annotation/json_annotation.dart';

part 'save_user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SaveUserModel {
  final int id;
  final String username;
  final String password;
  final String role;

  SaveUserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
  });

  factory SaveUserModel.fromJson(Map<String, dynamic> json) =>
      _$SaveUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SaveUserModelToJson(this);
}
