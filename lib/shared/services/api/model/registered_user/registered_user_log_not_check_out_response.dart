import 'package:carpark/shared/models/null_time_model.dart';
import 'package:carpark/shared/services/api/model/registered_user/registered_user_logs_response.dart';
import 'package:carpark/shared/services/api/model/registered_user/registered_user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registered_user_log_not_check_out_response.g.dart';

@JsonSerializable()
class RegisteredUserLogNotCheckOutResponse extends RegisteredUserLogResponse {
  const RegisteredUserLogNotCheckOutResponse({
    required super.id,
    required super.checkInTime,
    required super.checkOutTime,
    required super.registeredUser,
  });

  factory RegisteredUserLogNotCheckOutResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$RegisteredUserLogNotCheckOutResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$RegisteredUserLogNotCheckOutResponseToJson(this);
}
