part of 'registered_user_update_bloc.dart';

sealed class RegisteredUserUpdateEvent extends Equatable {
  const RegisteredUserUpdateEvent();

  @override
  List<Object> get props => [];
}

class GetRegisteredUser extends RegisteredUserUpdateEvent {

  const GetRegisteredUser(this.id);
  final int id;
}

class UpdateRegisteredUser extends RegisteredUserUpdateEvent {

  const UpdateRegisteredUser(this.request);
  final UpdateRegisteredUserRequest request;
}

class UpdateRegisteredUserSelectExpiredDate extends RegisteredUserUpdateEvent {

  const UpdateRegisteredUserSelectExpiredDate(this.expiredDates);
  final List<DateTime?> expiredDates;
}

class UpdateRegisteredUserSelectType extends RegisteredUserUpdateEvent {

  const UpdateRegisteredUserSelectType(this.type);
  final String type;
}
