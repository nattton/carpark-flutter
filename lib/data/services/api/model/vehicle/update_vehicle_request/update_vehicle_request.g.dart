// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_vehicle_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateVehicleRequest _$UpdateVehicleRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateVehicleRequest(
  id: (json['id'] as num?)?.toInt(),
  memberId: (json['memberId'] as num?)?.toInt(),
  plateNumber: json['plateNumber'] as String?,
  plateProvince: json['plateProvince'] as String?,
  brand: json['brand'] as String?,
  color: json['color'] as String?,
  telephone: json['telephone'] as String?,
  resemble: json['resemble'] as String?,
);

Map<String, dynamic> _$UpdateVehicleRequestToJson(
  _UpdateVehicleRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'memberId': instance.memberId,
  'plateNumber': instance.plateNumber,
  'plateProvince': instance.plateProvince,
  'brand': instance.brand,
  'color': instance.color,
  'telephone': instance.telephone,
  'resemble': instance.resemble,
};
