part of 'registered_user_list_bloc.dart';

sealed class RegisteredUserListEvent extends Equatable {
  const RegisteredUserListEvent();

  @override
  List<Object> get props => [];
}

class GetRegisteredUserList extends RegisteredUserListEvent {}

class SearchRegisteredUser extends RegisteredUserListEvent {

  const SearchRegisteredUser(this.searchText);
  final String searchText;

  @override
  List<Object> get props => [searchText];
}

class RegisteredUserCreating extends RegisteredUserListEvent {}

class RegisteredUserUpdating extends RegisteredUserListEvent {}
