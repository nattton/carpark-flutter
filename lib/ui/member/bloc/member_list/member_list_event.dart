part of 'member_list_bloc.dart';

sealed class MemberListEvent extends Equatable {
  const MemberListEvent();

  @override
  List<Object> get props => [];
}

class LoadMemberList extends MemberListEvent {}

class FilterMemberList extends MemberListEvent {

  const FilterMemberList(this.filter);
  final String filter;
}
