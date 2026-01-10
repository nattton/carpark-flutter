// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VehicleModel _$VehicleModelFromJson(Map<String, dynamic> json) =>
    _VehicleModel(
      id: (json['id'] as num?)?.toInt(),
      memberId: (json['memberId'] as num?)?.toInt(),
      plateNumber: json['plateNumber'] as String?,
      plateProvince: json['plateProvince'] as String?,
      brand: json['brand'] as String?,
      color: json['color'] as String?,
      telephone: json['telephone'] as String?,
      resemble: json['resemble'] as String?,
    );

Map<String, dynamic> _$VehicleModelToJson(_VehicleModel instance) =>
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
