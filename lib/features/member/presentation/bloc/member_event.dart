part of 'member_bloc.dart';

@freezed
class MemberEvent with _$MemberEvent {
  const factory MemberEvent.started() = _Started;
  const factory MemberEvent.getMember(int id) = GetMember;
  const factory MemberEvent.createMember(MemberModel member) = CreateMember;
  const factory MemberEvent.updateMember(MemberModel member) = UpdateMember;
}
