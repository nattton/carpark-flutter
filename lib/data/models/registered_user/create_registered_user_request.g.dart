// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_registered_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRegisteredUserRequest _$CreateRegisteredUserRequestFromJson(
  Map<String, dynamic> json,
) => CreateRegisteredUserRequest(
  type: json['type'] as String,
  telephone: json['telephone'] as String,
  idCard: json['idCard'] as String,
  thaiName: json['thaiName'] as String,
  engName: json['engName'] as String,
  birthdate: json['birthdate'] as String,
  gender: json['gender'] as String,
  address: json['address'] as String,
  expiredDate: json['expiredDate'] as String,
);

Map<String, dynamic> _$CreateRegisteredUserRequestToJson(
  CreateRegisteredUserRequest instance,
) => <String, dynamic>{
  'type': instance.type,
  'telephone': instance.telephone,
  'idCard': instance.idCard,
  'thaiName': instance.thaiName,
  'engName': instance.engName,
  'birthdate': instance.birthdate,
  'gender': instance.gender,
  'address': instance.address,
  'expiredDate': instance.expiredDate,
};
