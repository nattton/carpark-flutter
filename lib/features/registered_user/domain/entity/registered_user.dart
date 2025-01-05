import 'package:carpark/constants.dart';
import 'package:carpark/models/null_time_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registered_user.g.dart';

@JsonSerializable()
class RegisteredUser extends Equatable {
  final int id;
  final String generatedId;
  final String type;
  final String telephone;
  final String idCard;
  final String thaiName;
  final String engName;
  final String birthdate;
  final String gender;
  final String address;
  final String photo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final NullTimeModel expiredDate;

  const RegisteredUser(
      {required this.id,
      required this.generatedId,
      required this.type,
      required this.telephone,
      required this.idCard,
      required this.thaiName,
      required this.engName,
      required this.birthdate,
      required this.gender,
      required this.address,
      required this.photo,
      required this.createdAt,
      required this.updatedAt,
      required this.expiredDate});

  factory RegisteredUser.fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserFromJson(json);

  Map<String, dynamic> toJson() => _$RegisteredUserToJson(this);

  @override
  List<Object?> get props => [
        id,
        generatedId,
        type,
        telephone,
        idCard,
        thaiName,
        engName,
        birthdate,
        gender,
        address,
        photo,
        createdAt,
        updatedAt,
        expiredDate,
      ];

  String photoUrl() {
    if (photo.isNotEmpty) {
      return "$kHostUrl/anpr_store$photo";
    }
    return "";
  }
}
