import 'package:carpark/features/auth/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login_model.freezed.dart';
part 'user_login_model.g.dart';

@freezed
sealed class UserLoginModel with _$UserLoginModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserLoginModel({
    required String sessionId,
    required String accessToken,
    required DateTime accessTokenExpiresAt,
    required String refreshToken,
    required DateTime refreshTokenExpiresAt,
    required UserModel user,
  }) = _UserLoginModel;

  factory UserLoginModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginModelFromJson(json);
}
