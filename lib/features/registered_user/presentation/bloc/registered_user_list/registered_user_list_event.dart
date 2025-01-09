part of 'registered_user_list_bloc.dart';

sealed class RegisteredUserListEvent extends Equatable {
  const RegisteredUserListEvent();

  @override
  List<Object> get props => [];
}

class GetRegisteredUserList extends RegisteredUserListEvent {}

class SearchRegisteredUser extends RegisteredUserListEvent {
  final String searchText;

  const SearchRegisteredUser(this.searchText);

  @override
  List<Object> get props => [searchText];
}

class RegisteredUserCreateScreen extends RegisteredUserListEvent {}

class RegisteredUserUpdateScreen extends RegisteredUserListEvent {}
