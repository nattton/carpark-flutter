import 'package:json_annotation/json_annotation.dart';

part 'registered_user_check_out_request.g.dart';

@JsonSerializable()
class RegisteredUserCheckOutRequest {

  const RegisteredUserCheckOutRequest({required this.generatedId});

  factory RegisteredUserCheckOutRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisteredUserCheckOutRequestFromJson(json);
  final String generatedId;

  Map<String, dynamic> toJson() => _$RegisteredUserCheckOutRequestToJson(this);
}
