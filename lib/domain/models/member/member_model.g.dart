// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => _MemberModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  telephone: json['telephone'] as String?,
  type: json['type'] as String?,
  status: json['status'] as String?,
  vehicles: (json['vehicles'] as List<dynamic>?)
      ?.map((e) => VehicleModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MemberModelToJson(_MemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'telephone': instance.telephone,
      'type': instance.type,
      'status': instance.status,
      'vehicles': instance.vehicles,
    };
