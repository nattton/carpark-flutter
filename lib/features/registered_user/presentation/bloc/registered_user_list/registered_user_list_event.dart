part of 'registered_user_list_bloc.dart';

sealed class RegisteredUserListEvent extends Equatable {
  const RegisteredUserListEvent();

  @override
  List<Object> get props => [];
}

class GetRegisteredUserList extends RegisteredUserListEvent {}
