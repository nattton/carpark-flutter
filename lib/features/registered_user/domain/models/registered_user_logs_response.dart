import 'package:carpark/features/registered_user/domain/entity/registered_user_log.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';
import 'package:carpark/models/null_time_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registered_user_logs_response.g.dart';

@JsonSerializable()
class RegisteredUserLogsResponse extends Equatable {
  final RegisteredUserResponse registeredUser;
  final List<RegisteredUserLogResponse> logs;

  const RegisteredUserLogsResponse({
    required this.registeredUser,
    required this.logs,
  });

  factory RegisteredUserLogsResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserLogsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisteredUserLogsResponseToJson(this);

  @override
  List<Object?> get props => [registeredUser, logs];
}

@JsonSerializable()
class RegisteredUserLogResponse extends RegisteredUserLog {
  @override
  final int id;
  @override
  final NullTimeModel checkInTime;
  @override
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
