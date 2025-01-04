part of 'registered_user_list_bloc.dart';

sealed class RegisteredUserListState extends Equatable {
  const RegisteredUserListState();

  @override
  List<Object> get props => [];
}

final class RegisteredUserListInitial extends RegisteredUserListState {}

final class RegisteredUserListLoading extends RegisteredUserListState {}

final class RegisteredUserListSuccess extends RegisteredUserListState {
  final List<RegisteredUser> registeredUsers;

  const RegisteredUserListSuccess(this.registeredUsers);

  @override
  List<Object> get props => [registeredUsers];
}

final class RegisteredUserListFailure extends RegisteredUserListState {
  final String message;

  const RegisteredUserListFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class RegisteredUserListCreating extends RegisteredUserListState {}
