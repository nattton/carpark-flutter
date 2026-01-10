// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'null_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NullTimeModel _$NullTimeModelFromJson(Map<String, dynamic> json) =>
    NullTimeModel(
      time: json['Time'] == null
          ? null
          : DateTime.parse(json['Time'] as String),
      valid: json['Valid'] as bool?,
    );

Map<String, dynamic> _$NullTimeModelToJson(NullTimeModel instance) =>
    <String, dynamic>{
      'Time': instance.time?.toIso8601String(),
      'Valid': instance.valid,
    };
