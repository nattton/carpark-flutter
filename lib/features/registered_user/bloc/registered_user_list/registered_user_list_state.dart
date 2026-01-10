part of 'registered_user_list_bloc.dart';

sealed class RegisteredUserListState extends Equatable {
  const RegisteredUserListState();

  @override
  List<Object> get props => [];
}

final class RegisteredUserListInitial extends RegisteredUserListState {}

final class RegisteredUserListLoading extends RegisteredUserListState {}

final class RegisteredUserListSuccess extends RegisteredUserListState {

  const RegisteredUserListSuccess(this.registeredUsers);
  final List<RegisteredUser> registeredUsers;

  @override
  List<Object> get props => [registeredUsers];
}

final class RegisteredUserListFailure extends RegisteredUserListState {

  const RegisteredUserListFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

final class RegisteredUserListCreating extends RegisteredUserListState {}

final class RegisteredUserListUpdating extends RegisteredUserListState {}
