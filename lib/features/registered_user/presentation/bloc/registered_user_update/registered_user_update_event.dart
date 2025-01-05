part of 'registered_user_update_bloc.dart';

sealed class RegisteredUserUpdateEvent extends Equatable {
  const RegisteredUserUpdateEvent();

  @override
  List<Object> get props => [];
}

class Initial extends RegisteredUserUpdateEvent {}

class UpdateRegisteredUser extends RegisteredUserUpdateEvent {
  final UpdateRegisteredUserRequest request;

  const UpdateRegisteredUser(this.request);
}
