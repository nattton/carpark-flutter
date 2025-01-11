import 'package:carpark/features/registered_user/domain/models/registered_user_logs_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_registered_user_log_not_check_out_response.g.dart';

@JsonSerializable()
class GetRegisteredUserLogNotCheckOutResponse {
  final List<RegisteredUserLogResponse> logs;

  const GetRegisteredUserLogNotCheckOutResponse({
    required this.logs,
  });

  factory GetRegisteredUserLogNotCheckOutResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetRegisteredUserLogNotCheckOutResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetRegisteredUserLogNotCheckOutResponseToJson(this);
}
