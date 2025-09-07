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

  const SelectExpiredDate(this.expiredDates);
  final List<DateTime?> expiredDates;
}

class CreateRegisteredUser extends RegisteredUserCreateEvent {

  const CreateRegisteredUser(this.request);
  final CreateRegisteredUserRequest request;
}
