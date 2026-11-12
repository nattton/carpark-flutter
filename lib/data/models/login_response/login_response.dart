import 'package:carpark/data/models/login_response/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  const new({
    required this.token,
    required this.user,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  final String token;
  final UserModel user;

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
