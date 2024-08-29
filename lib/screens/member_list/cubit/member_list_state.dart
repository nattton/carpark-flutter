part of 'member_list_cubit.dart';

@freezed
class MemberListState with _$MemberListState {
  const factory MemberListState({
    @Default([]) List<MemberModel> members,
    @Default([]) List<MemberModel> filteredMembers,
  }) = _MemberListState;
}
