part of 'registered_user_update_bloc.dart';

sealed class RegisteredUserUpdateEvent extends Equatable {
  const RegisteredUserUpdateEvent();

  @override
  List<Object> get props => [];
}

class GetRegisteredUser extends RegisteredUserUpdateEvent {
  final int id;

  const GetRegisteredUser(this.id);
}

class UpdateRegisteredUser extends RegisteredUserUpdateEvent {
  final UpdateRegisteredUserRequest request;

  const UpdateRegisteredUser(this.request);
}

class UpdateRegisteredUserSelectExpiredDate extends RegisteredUserUpdateEvent {
  final List<DateTime?> expiredDates;

  const UpdateRegisteredUserSelectExpiredDate(this.expiredDates);
}
