// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveUserModel _$SaveUserModelFromJson(Map<String, dynamic> json) =>
    SaveUserModel(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$SaveUserModelToJson(SaveUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'role': instance.role,
    };
