part of 'registered_user_create_bloc.dart';

sealed class RegisteredUserCreateEvent extends Equatable {
  const RegisteredUserCreateEvent();

  @override
  List<Object> get props => [];
}

class InitialCreateRegisteredUser extends RegisteredUserCreateEvent {}

class ReadIdCard extends RegisteredUserCreateEvent {}

class SavePhoto extends RegisteredUserCreateEvent {}

class SelectExpiredDate extends RegisteredUserCreateEvent {
  final List<DateTime?> expiredDates;

  const SelectExpiredDate(this.expiredDates);
}

class CreateRegisteredUser extends RegisteredUserCreateEvent {
  final CreateRegisteredUserRequest request;

  const CreateRegisteredUser(this.request);
}
