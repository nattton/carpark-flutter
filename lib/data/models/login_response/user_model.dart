import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  const new({
    required this.id,
    required this.name,
    required this.role,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  final int id;
  final String name;
  final String role;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
