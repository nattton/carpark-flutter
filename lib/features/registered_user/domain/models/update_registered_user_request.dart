import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_registered_user_request.g.dart';

@JsonSerializable()
class UpdateRegisteredUserRequest extends Equatable {
  final int id;
  final String type;
  final String telephone;
  final String idCard;
  final String thaiName;
  final String engName;
  final String birthdate;
  final String gender;
  final String address;
  final String age;
  final String expiredDate;

  const UpdateRegisteredUserRequest({
    required this.id,
    required this.type,
    required this.telephone,
    required this.idCard,
    required this.thaiName,
    required this.engName,
    required this.birthdate,
    required this.gender,
    required this.address,
    required this.age,
    required this.expiredDate,
  });

  factory UpdateRegisteredUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateRegisteredUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRegisteredUserRequestToJson(this);

  @override
  List<Object?> get props => [
        type,
        telephone,
        idCard,
        thaiName,
        engName,
        birthdate,
        gender,
        address,
        age,
        expiredDate,
      ];
}
