// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gate_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GateLogModel _$GateLogModelFromJson(Map<String, dynamic> json) => GateLogModel(
  (json['id'] as num).toInt(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  gateName: json['gateName'] as String?,
  anpr: json['anpr'] as String?,
  plateNumber: json['plateNumber'] as String?,
  memberId: (json['memberId'] as num?)?.toInt(),
  member: json['member'] == null
      ? null
      : MemberModel.fromJson(json['member'] as Map<String, dynamic>),
  captureTime: json['captureTime'] == null
      ? null
      : DateTime.parse(json['captureTime'] as String),
  captureImage: json['captureImage'] as String?,
  licensePlateImage: json['licensePlateImage'] as String?,
);

Map<String, dynamic> _$GateLogModelToJson(GateLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'gateName': instance.gateName,
      'anpr': instance.anpr,
      'plateNumber': instance.plateNumber,
      'memberId': instance.memberId,
      'member': instance.member,
      'captureTime': instance.captureTime?.toIso8601String(),
      'captureImage': instance.captureImage,
      'licensePlateImage': instance.licensePlateImage,
    };
