part of 'member_list_bloc.dart';

enum MemberListStatus {
  initial,
  loading,
  success,
  failure,
}

class MemberListState extends Equatable {
  final MemberListStatus status;
  final List<MemberModel> members;
  final String errorMessage;
  final String filter;
  final List<MemberModel> filteredMembers;

  const MemberListState({
    this.status = MemberListStatus.initial,
    this.members = const [],
    this.errorMessage = '',
    this.filter = '',
    this.filteredMembers = const [],
  });

  @override
  List<Object> get props =>
      [status, members, errorMessage, filter, filteredMembers];

  MemberListState copyWith({
    MemberListStatus? status,
    List<MemberModel>? members,
    String? errorMessage,
    String? filter,
    List<MemberModel>? filteredMembers,
  }) {
    return MemberListState(
      status: status ?? this.status,
      members: members ?? this.members,
      errorMessage: errorMessage ?? this.errorMessage,
      filter: filter ?? this.filter,
      filteredMembers: filteredMembers ?? this.filteredMembers,
    );
  }
}
