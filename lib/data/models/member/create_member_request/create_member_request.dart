import 'package:json_annotation/json_annotation.dart';

part 'create_member_request.g.dart';

@JsonSerializable()
class CreateMemberRequest {
  const new({
    this.name,
    this.telephone,
    this.type,
    this.status,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$CreateMemberRequestFromJson(json);

  final String? name;
  final String? telephone;
  final String? type;
  final String? status;

  Map<String, dynamic> toJson() => _$CreateMemberRequestToJson(this);
}
