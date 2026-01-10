// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_member_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateMemberRequest _$CreateMemberRequestFromJson(Map<String, dynamic> json) =>
    _CreateMemberRequest(
      name: json['name'] as String?,
      telephone: json['telephone'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CreateMemberRequestToJson(
  _CreateMemberRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'telephone': instance.telephone,
  'type': instance.type,
  'status': instance.status,
};
