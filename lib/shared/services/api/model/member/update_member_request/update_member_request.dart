import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_member_request.freezed.dart';
part 'update_member_request.g.dart';

@freezed
abstract class UpdateMemberRequest with _$UpdateMemberRequest {
  const factory UpdateMemberRequest({
    String? name,
    String? telephone,
    String? type,
    String? status,
  }) = _UpdateMemberRequest;

  factory UpdateMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateMemberRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$UpdateMemberRequestToJson(this as _UpdateMemberRequest);
}
