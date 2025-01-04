import 'package:json_annotation/json_annotation.dart';

part 'registered_user_check_in_request.g.dart';

@JsonSerializable()
class RegisteredUserCheckInRequest {
  final String generatedId;

  const RegisteredUserCheckInRequest({
    required this.generatedId,
  });

  factory RegisteredUserCheckInRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserCheckInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisteredUserCheckInRequestToJson(this);
}
