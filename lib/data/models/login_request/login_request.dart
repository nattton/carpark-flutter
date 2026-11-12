import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  const new({
    required this.username,
    required this.password,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  final String username;
  final String password;

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
