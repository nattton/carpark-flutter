import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_member_request.freezed.dart';
part 'create_member_request.g.dart';

@freezed
abstract class CreateMemberRequest with _$CreateMemberRequest {
  const factory CreateMemberRequest({
    String? name,
    String? telephone,
    String? type,
    String? status,
  }) = _CreateMemberRequest;

  factory CreateMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateMemberRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$CreateMemberRequestToJson(this as _CreateMemberRequest);
}
