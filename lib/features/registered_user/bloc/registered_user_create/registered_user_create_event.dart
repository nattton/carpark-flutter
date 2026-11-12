part of 'registered_user_create_bloc.dart';

sealed class RegisteredUserCreateEvent {
  const RegisteredUserCreateEvent();
}

final class InitialCreateRegisteredUser extends RegisteredUserCreateEvent {}

final class ReadIdCard extends RegisteredUserCreateEvent {}

final class SavePhoto extends RegisteredUserCreateEvent {}

final class SelectExpiredDate extends RegisteredUserCreateEvent {
  const SelectExpiredDate(this.expiredDates);
  final List<DateTime?> expiredDates;
}

final class CreateRegisteredUser extends RegisteredUserCreateEvent {
  const CreateRegisteredUser(this.request);
  final CreateRegisteredUserRequest request;
}
