// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_member_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateMemberRequest _$UpdateMemberRequestFromJson(Map<String, dynamic> json) =>
    _UpdateMemberRequest(
      name: json['name'] as String?,
      telephone: json['telephone'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$UpdateMemberRequestToJson(
  _UpdateMemberRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'telephone': instance.telephone,
  'type': instance.type,
  'status': instance.status,
};
