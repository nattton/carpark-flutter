part of 'registered_user_create_bloc.dart';

sealed class RegisteredUserCreateEvent extends Equatable {
  const RegisteredUserCreateEvent();

  @override
  List<Object> get props => [];
}

class Initial extends RegisteredUserCreateEvent {}

class ReadSmartCard extends RegisteredUserCreateEvent {}

class CreateRegisteredUser extends RegisteredUserCreateEvent {
  final CreateRegisteredUserRequest request;

  const CreateRegisteredUser(this.request);
}
