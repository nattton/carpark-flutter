// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id_card_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IDCardEntity _$IDCardEntityFromJson(Map<String, dynamic> json) => IDCardEntity(
  id: json['id'] as String,
  engName: json['engName'] as String,
  thaiName: json['thaiName'] as String,
  birthdate: json['birthdate'] as String,
  gender: json['gender'] as String,
  address: json['address'] as String,
  photoPath: json['photoPath'] as String,
);

Map<String, dynamic> _$IDCardEntityToJson(IDCardEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'engName': instance.engName,
      'thaiName': instance.thaiName,
      'birthdate': instance.birthdate,
      'gender': instance.gender,
      'address': instance.address,
      'photoPath': instance.photoPath,
    };
