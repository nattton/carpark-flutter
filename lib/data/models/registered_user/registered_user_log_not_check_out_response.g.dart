// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registered_user_log_not_check_out_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisteredUserLogNotCheckOutResponse
_$RegisteredUserLogNotCheckOutResponseFromJson(Map<String, dynamic> json) =>
    RegisteredUserLogNotCheckOutResponse(
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

Map<String, dynamic> _$RegisteredUserLogNotCheckOutResponseToJson(
  RegisteredUserLogNotCheckOutResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'checkInTime': instance.checkInTime,
  'checkOutTime': instance.checkOutTime,
  'registeredUser': instance.registeredUser,
};
