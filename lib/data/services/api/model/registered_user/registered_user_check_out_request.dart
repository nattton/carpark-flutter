import 'package:json_annotation/json_annotation.dart';

part 'registered_user_check_out_request.g.dart';

@JsonSerializable()
class RegisteredUserCheckOutRequest {
  final String generatedId;

  const RegisteredUserCheckOutRequest({required this.generatedId});

  factory RegisteredUserCheckOutRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserCheckOutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisteredUserCheckOutRequestToJson(this);
}
