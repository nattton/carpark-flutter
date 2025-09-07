import 'package:carpark/data/services/api/model/registered_user/registered_user_logs_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_registered_user_log_not_check_out_response.g.dart';

@JsonSerializable()
class GetRegisteredUserLogNotCheckOutResponse {

  const GetRegisteredUserLogNotCheckOutResponse({required this.logs});

  factory GetRegisteredUserLogNotCheckOutResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$GetRegisteredUserLogNotCheckOutResponseFromJson(json);
  final List<RegisteredUserLogResponse> logs;

  Map<String, dynamic> toJson() =>
      _$GetRegisteredUserLogNotCheckOutResponseToJson(this);
}
