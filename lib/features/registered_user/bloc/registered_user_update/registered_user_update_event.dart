part of 'registered_user_update_bloc.dart';

sealed class RegisteredUserUpdateEvent {
  const RegisteredUserUpdateEvent();
}

final class GetRegisteredUser extends RegisteredUserUpdateEvent {
  const GetRegisteredUser(this.id);
  final int id;
}

final class UpdateRegisteredUser extends RegisteredUserUpdateEvent {
  const UpdateRegisteredUser(this.request);
  final UpdateRegisteredUserRequest request;
}

final class UpdateRegisteredUserSelectExpiredDate
    extends RegisteredUserUpdateEvent {
  const UpdateRegisteredUserSelectExpiredDate(this.expiredDates);
  final List<DateTime?> expiredDates;
}

final class UpdateRegisteredUserSelectType extends RegisteredUserUpdateEvent {
  const UpdateRegisteredUserSelectType(this.type);
  final String type;
}
