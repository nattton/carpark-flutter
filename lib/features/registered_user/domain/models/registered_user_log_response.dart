import 'package:carpark/models/null_time_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registered_user_log_response.g.dart';

@JsonSerializable()
class RegisteredUserLogResponse extends Equatable {
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

  @override
  List<Object?> get props => [id, checkInTime, checkOutTime];
}
