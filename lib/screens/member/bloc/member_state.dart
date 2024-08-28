part of 'member_bloc.dart';

@freezed
class MemberState with _$MemberState {
  const factory MemberState.initial() = _Initial;
  const factory MemberState.loading() = Loading;
  const factory MemberState.success({
    required MemberModel member,
  }) = Success;
  const factory MemberState.error({
    required String message,
  }) = Error;
  const factory MemberState.updateSuccess() = UpdateSuccess;
}
