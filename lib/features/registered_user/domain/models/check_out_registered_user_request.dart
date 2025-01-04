import 'package:json_annotation/json_annotation.dart';

part 'check_out_registered_user_request.g.dart';

@JsonSerializable()
class CheckOutRegisteredUserRequest {
  final String generatedId;

  const CheckOutRegisteredUserRequest({
    required this.generatedId,
  });

  factory CheckOutRegisteredUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckOutRegisteredUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutRegisteredUserRequestToJson(this);
}
