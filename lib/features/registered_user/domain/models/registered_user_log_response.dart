import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';
import 'package:carpark/models/null_time_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registered_user_log_response.g.dart';

@JsonSerializable()
class RegisteredUserLogResponse extends Equatable {
  final RegisteredUserResponse registeredUser;
  final List<LogResponse> logs;

  const RegisteredUserLogResponse({
    required this.registeredUser,
    required this.logs,
  });

  factory RegisteredUserLogResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserLogResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisteredUserLogResponseToJson(this);

  @override
  List<Object?> get props => [registeredUser, logs];
}

@JsonSerializable()
class LogResponse extends Equatable {
  final int id;
  final NullTimeModel checkInTime;
  final NullTimeModel checkOutTime;

  const LogResponse({
    required this.id,
    required this.checkInTime,
    required this.checkOutTime,
  });

  factory LogResponse.fromJson(Map<String, dynamic> json) =>
      _$LogResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LogResponseToJson(this);

  @override
  List<Object?> get props => [id, checkInTime, checkOutTime];
}
