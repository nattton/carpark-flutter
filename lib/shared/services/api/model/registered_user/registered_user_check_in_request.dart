import 'package:json_annotation/json_annotation.dart';

part 'registered_user_check_in_request.g.dart';

@JsonSerializable()
class RegisteredUserCheckInRequest {

  const RegisteredUserCheckInRequest({required this.generatedId});

  factory RegisteredUserCheckInRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserCheckInRequestFromJson(json);
  final String generatedId;

  Map<String, dynamic> toJson() => _$RegisteredUserCheckInRequestToJson(this);
}
