import 'package:carpark/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_user_model.g.dart';

@JsonSerializable()
class LoginUserModel {
  String token;
  UserModel user;

  LoginUserModel({
    required this.token,
    required this.user,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) =>
      _$LoginUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginUserModelToJson(this);
}
