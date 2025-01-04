import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'registered_user_log_response.dart';
import 'registered_user_response.dart';

part 'list_registered_user_response.g.dart';

@JsonSerializable()
class ListRegisteredUserResponse extends Equatable {
  final RegisteredUserResponse registeredUser;
  final List<RegisteredUserLogResponse> logs;

  const ListRegisteredUserResponse({
    required this.registeredUser,
    required this.logs,
  });

  factory ListRegisteredUserResponse.fromJson(Map<String, dynamic> json) =>
      _$ListRegisteredUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListRegisteredUserResponseToJson(this);

  @override
  List<Object?> get props => [registeredUser, logs];
}
