part of 'registered_user_list_bloc.dart';

sealed class RegisteredUserListEvent {
  const RegisteredUserListEvent();
}

final class GetRegisteredUserList extends RegisteredUserListEvent {}

final class SearchRegisteredUser extends RegisteredUserListEvent {
  const SearchRegisteredUser(this.searchText);
  final String searchText;
}

final class RegisteredUserCreating extends RegisteredUserListEvent {}

final class RegisteredUserUpdating extends RegisteredUserListEvent {}
