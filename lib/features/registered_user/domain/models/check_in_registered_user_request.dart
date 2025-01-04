import 'package:json_annotation/json_annotation.dart';

part 'check_in_registered_user_request.g.dart';

@JsonSerializable()
class CheckInRegisteredUserRequest {
  final String generatedId;

  const CheckInRegisteredUserRequest({
    required this.generatedId,
  });

  factory CheckInRegisteredUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckInRegisteredUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInRegisteredUserRequestToJson(this);
}
