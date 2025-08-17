import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_registered_user_request.g.dart';

@JsonSerializable()
class CreateRegisteredUserRequest extends Equatable {
  final String type;
  final String telephone;
  final String idCard;
  final String thaiName;
  final String engName;
  final String birthdate;
  final String gender;
  final String address;
  final String expiredDate;

  const CreateRegisteredUserRequest({
    required this.type,
    required this.telephone,
    required this.idCard,
    required this.thaiName,
    required this.engName,
    required this.birthdate,
    required this.gender,
    required this.address,
    required this.expiredDate,
  });

  factory CreateRegisteredUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateRegisteredUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRegisteredUserRequestToJson(this);

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
    expiredDate,
  ];
}
