// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMemberResponse _$GetMemberResponseFromJson(Map<String, dynamic> json) =>
    GetMemberResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      telephone: json['telephone'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      vehicles: (json['vehicles'] as List<dynamic>?)
          ?.map((e) => VehicleResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMemberResponseToJson(GetMemberResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'telephone': instance.telephone,
      'type': instance.type,
      'status': instance.status,
      'vehicles': instance.vehicles,
    };

VehicleResponse _$VehicleResponseFromJson(Map<String, dynamic> json) =>
    VehicleResponse(
      id: (json['id'] as num?)?.toInt(),
      memberId: (json['memberId'] as num?)?.toInt(),
      plateNumber: json['plateNumber'] as String?,
      plateProvince: json['plateProvince'] as String?,
      brand: json['brand'] as String?,
      color: json['color'] as String?,
      telephone: json['telephone'] as String?,
      resemble: json['resemble'] as String?,
    );

Map<String, dynamic> _$VehicleResponseToJson(VehicleResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'plateNumber': instance.plateNumber,
      'plateProvince': instance.plateProvince,
      'brand': instance.brand,
      'color': instance.color,
      'telephone': instance.telephone,
      'resemble': instance.resemble,
    };
