// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CameraModel _$CameraModelFromJson(Map<String, dynamic> json) => CameraModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  ipAddress: json['ipAddress'] as String,
  port: json['port'] as String,
  username: json['username'] as String,
  password: json['password'] as String,
  path: json['path'] as String,
);

Map<String, dynamic> _$CameraModelToJson(CameraModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ipAddress': instance.ipAddress,
      'port': instance.port,
      'username': instance.username,
      'password': instance.password,
      'path': instance.path,
    };
