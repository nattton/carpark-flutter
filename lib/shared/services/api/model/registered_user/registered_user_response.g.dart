// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registered_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisteredUserResponse _$RegisteredUserResponseFromJson(
  Map<String, dynamic> json,
) => RegisteredUserResponse(
  id: (json['id'] as num).toInt(),
  generatedId: json['generatedId'] as String,
  type: json['type'] as String,
  telephone: json['telephone'] as String,
  idCard: json['idCard'] as String,
  thaiName: json['thaiName'] as String,
  engName: json['engName'] as String,
  birthdate: json['birthdate'] as String,
  gender: json['gender'] as String,
  address: json['address'] as String,
  photo: json['photo'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  expiredDate: NullTimeModel.fromJson(
    json['expiredDate'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$RegisteredUserResponseToJson(
  RegisteredUserResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'generatedId': instance.generatedId,
  'type': instance.type,
  'telephone': instance.telephone,
  'idCard': instance.idCard,
  'thaiName': instance.thaiName,
  'engName': instance.engName,
  'birthdate': instance.birthdate,
  'gender': instance.gender,
  'address': instance.address,
  'photo': instance.photo,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'expiredDate': instance.expiredDate,
};
