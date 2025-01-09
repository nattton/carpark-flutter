import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';
import 'package:carpark/models/null_time_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registered_user_logs_response.g.dart';

@JsonSerializable()
class RegisteredUserLogsResponse {
  final RegisteredUserResponse registeredUser;
  final List<RegisteredUserLogResponse> logs;

  const RegisteredUserLogsResponse({
    required this.registeredUser,
    required this.logs,
  });

  factory RegisteredUserLogsResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserLogsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisteredUserLogsResponseToJson(this);
}

@JsonSerializable()
class RegisteredUserLogResponse {
  final int id;
  final NullTimeModel checkInTime;
  final NullTimeModel checkOutTime;

  const RegisteredUserLogResponse({
    required this.id,
    required this.checkInTime,
    required this.checkOutTime,
  });

  factory RegisteredUserLogResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserLogResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisteredUserLogResponseToJson(this);
}
