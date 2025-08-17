// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_vehicle_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateVehicleRequest _$CreateVehicleRequestFromJson(
  Map<String, dynamic> json,
) => _CreateVehicleRequest(
  memberId: (json['memberId'] as num?)?.toInt(),
  plateNumber: json['plateNumber'] as String?,
  plateProvince: json['plateProvince'] as String?,
  brand: json['brand'] as String?,
  color: json['color'] as String?,
  telephone: json['telephone'] as String?,
  resemble: json['resemble'] as String?,
);

Map<String, dynamic> _$CreateVehicleRequestToJson(
  _CreateVehicleRequest instance,
) => <String, dynamic>{
  'memberId': instance.memberId,
  'plateNumber': instance.plateNumber,
  'plateProvince': instance.plateProvince,
  'brand': instance.brand,
  'color': instance.color,
  'telephone': instance.telephone,
  'resemble': instance.resemble,
};
