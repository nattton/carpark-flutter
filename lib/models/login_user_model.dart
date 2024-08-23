import 'package:carpark/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginUserModel {
  final String sessionId;
  final String accessToken;
  final DateTime accessTokenExpiresAt;
  final String refreshToken;
  final DateTime refreshTokenExpiresAt;
  final UserModel user;

  const LoginUserModel({
    required this.sessionId,
    required this.accessToken,
    required this.accessTokenExpiresAt,
    required this.refreshToken,
    required this.refreshTokenExpiresAt,
    required this.user,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) =>
      _$LoginUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginUserModelToJson(this);
}
