import 'package:json_annotation/json_annotation.dart';

part 'update_member_request.g.dart';

@JsonSerializable()
class UpdateMemberRequest {
  const new({
    this.name,
    this.telephone,
    this.type,
    this.status,
  });

  factory fromJson(Map<String, dynamic> json) =>
      _$UpdateMemberRequestFromJson(json);

  final String? name;
  final String? telephone;
  final String? type;
  final String? status;

  Map<String, dynamic> toJson() => _$UpdateMemberRequestToJson(this);
}
