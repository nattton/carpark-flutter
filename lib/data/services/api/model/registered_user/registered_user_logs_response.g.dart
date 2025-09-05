// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registered_user_logs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisteredUserLogsResponse _$RegisteredUserLogsResponseFromJson(
  Map<String, dynamic> json,
) => RegisteredUserLogsResponse(
  registeredUser: RegisteredUserResponse.fromJson(
    json['registeredUser'] as Map<String, dynamic>,
  ),
  logs: (json['logs'] as List<dynamic>)
      .map((e) => RegisteredUserLogResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RegisteredUserLogsResponseToJson(
  RegisteredUserLogsResponse instance,
) => <String, dynamic>{
  'registeredUser': instance.registeredUser,
  'logs': instance.logs,
};

RegisteredUserLogResponse _$RegisteredUserLogResponseFromJson(
  Map<String, dynamic> json,
) => RegisteredUserLogResponse(
  id: (json['id'] as num).toInt(),
  checkInTime: NullTimeModel.fromJson(
    json['checkInTime'] as Map<String, dynamic>,
  ),
  checkOutTime: NullTimeModel.fromJson(
    json['checkOutTime'] as Map<String, dynamic>,
  ),
  registeredUser: json['registeredUser'] == null
      ? null
      : RegisteredUserResponse.fromJson(
          json['registeredUser'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$RegisteredUserLogResponseToJson(
  RegisteredUserLogResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'checkInTime': instance.checkInTime.toJson(),
  'checkOutTime': instance.checkOutTime.toJson(),
  'registeredUser': instance.registeredUser?.toJson(),
};
