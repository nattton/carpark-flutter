import 'package:json_annotation/json_annotation.dart';

part 'registered_user.g.dart';

@JsonSerializable()
class RegisteredUser {
  final String id;
  final int type;
  final int idCard;
  final String thaiName;
  final String engName;
  final String birthdate;
  final String gender;
  final String address;
  final String age;
  final String photo;
  final String telephone;

  RegisteredUser(
      {required this.id,
      required this.type,
      required this.idCard,
      required this.thaiName,
      required this.engName,
      required this.birthdate,
      required this.gender,
      required this.address,
      required this.age,
      required this.photo,
      required this.telephone});

  factory RegisteredUser.fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserFromJson(json);

  Map<String, dynamic> toJson() => _$RegisteredUserToJson(this);
}
