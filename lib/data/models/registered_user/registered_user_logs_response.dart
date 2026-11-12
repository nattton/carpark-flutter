import 'package:carpark/data/models/registered_user/registered_user_response.dart';
import 'package:carpark/domain/models/null_time_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registered_user_logs_response.g.dart';

@JsonSerializable()
class RegisteredUserLogsResponse {
  const new({
    required this.registeredUser,
    required this.logs,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserLogsResponseFromJson(json);
  final RegisteredUserResponse registeredUser;
  final List<RegisteredUserLogResponse> logs;

  Map<String, dynamic> toJson() => _$RegisteredUserLogsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RegisteredUserLogResponse {
  const new({
    required this.id,
    required this.checkInTime,
    required this.checkOutTime,
    required this.registeredUser,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserLogResponseFromJson(json);
  final int id;
  final NullTimeModel checkInTime;
  final NullTimeModel checkOutTime;
  final RegisteredUserResponse? registeredUser;

  Map<String, dynamic> toJson() => _$RegisteredUserLogResponseToJson(this);
}
