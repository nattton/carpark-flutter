// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gate_log_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GateLogResult _$GateLogResultFromJson(Map<String, dynamic> json) =>
    GateLogResult(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      gateName: json['gateName'] as String,
      anpr: json['anpr'] as String,
      plateNumber: json['plateNumber'] as String,
      captureImage: json['captureImage'] as String,
      memberId: json['memberId'] as String,
      memberName: json['memberName'] as String,
      visitorId: (json['visitorId'] as num).toInt(),
      visitorMemberId: (json['visitorMemberId'] as num).toInt(),
      visitorMemberName: json['visitorMemberName'] as String,
    );

Map<String, dynamic> _$GateLogResultToJson(GateLogResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'gateName': instance.gateName,
      'anpr': instance.anpr,
      'plateNumber': instance.plateNumber,
      'captureImage': instance.captureImage,
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'visitorId': instance.visitorId,
      'visitorMemberId': instance.visitorMemberId,
      'visitorMemberName': instance.visitorMemberName,
    };
