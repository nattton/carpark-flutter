// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_traffic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportTrafficModel _$ReportTrafficModelFromJson(Map<String, dynamic> json) =>
    ReportTrafficModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      vehicleId: (json['vehicle_id'] as num).toInt(),
      plateNumber: json['plate_number'] as String,
      traffic: (json['traffic'] as num).toInt(),
    );

Map<String, dynamic> _$ReportTrafficModelToJson(ReportTrafficModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'vehicle_id': instance.vehicleId,
      'plate_number': instance.plateNumber,
      'traffic': instance.traffic,
    };
