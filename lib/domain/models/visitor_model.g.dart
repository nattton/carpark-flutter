// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorModel _$VisitorModelFromJson(Map<String, dynamic> json) =>
    VisitorModel(
        (json['id'] as num).toInt(),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        type: json['type'] as String?,
        plateNumber: json['plateNumber'] as String?,
        memberId: (json['memberId'] as num?)?.toInt(),
        member: json['member'] == null
            ? null
            : MemberModel.fromJson(json['member'] as Map<String, dynamic>),
        gateLogId: (json['gateLogId'] as num?)?.toInt(),
        gateLog: json['gateLog'] == null
            ? null
            : GateLogModel.fromJson(json['gateLog'] as Map<String, dynamic>),
        idCard: json['idCard'] as String?,
        thaiName: json['thaiName'] as String?,
        engName: json['engName'] as String?,
        birthdate: json['birthdate'] as String?,
        gender: json['gender'] as String?,
        address: json['address'] as String?,
        age: json['age'] as String?,
        photo: json['photo'] as String?,
        exitTime: json['exitTime'] == null
            ? null
            : NullTimeModel.fromJson(json['exitTime'] as Map<String, dynamic>),
        visitorImages: (json['visitorImages'] as List<dynamic>?)
            ?.map((e) => VisitorImageModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      )
      ..gateLogOutId = (json['gateLogOutId'] as num?)?.toInt()
      ..gateLogOut = json['gateLogOut'] == null
          ? null
          : GateLogModel.fromJson(json['gateLogOut'] as Map<String, dynamic>);

Map<String, dynamic> _$VisitorModelToJson(VisitorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'type': instance.type,
      'plateNumber': instance.plateNumber,
      'memberId': instance.memberId,
      'member': instance.member,
      'gateLogId': instance.gateLogId,
      'gateLog': instance.gateLog,
      'gateLogOutId': instance.gateLogOutId,
      'gateLogOut': instance.gateLogOut,
      'idCard': instance.idCard,
      'thaiName': instance.thaiName,
      'engName': instance.engName,
      'birthdate': instance.birthdate,
      'gender': instance.gender,
      'address': instance.address,
      'age': instance.age,
      'photo': instance.photo,
      'exitTime': instance.exitTime,
      'visitorImages': instance.visitorImages,
    };
