// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_registered_user_log_not_check_out_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRegisteredUserLogNotCheckOutResponse
_$GetRegisteredUserLogNotCheckOutResponseFromJson(Map<String, dynamic> json) =>
    GetRegisteredUserLogNotCheckOutResponse(
      logs: (json['logs'] as List<dynamic>)
          .map(
            (e) =>
                RegisteredUserLogResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$GetRegisteredUserLogNotCheckOutResponseToJson(
  GetRegisteredUserLogNotCheckOutResponse instance,
) => <String, dynamic>{'logs': instance.logs};
