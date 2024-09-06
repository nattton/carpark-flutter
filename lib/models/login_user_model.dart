import 'package:carpark/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_user_model.freezed.dart';
part 'login_user_model.g.dart';

@freezed
sealed class LoginUserModel with _$LoginUserModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LoginUserModel({
    required String sessionId,
    required String accessToken,
    required DateTime accessTokenExpiresAt,
    required String refreshToken,
    required DateTime refreshTokenExpiresAt,
    required UserModel user,
  }) = _LoginUserModel;

  factory LoginUserModel.fromJson(Map<String, dynamic> json) =>
      _$LoginUserModelFromJson(json);
}
