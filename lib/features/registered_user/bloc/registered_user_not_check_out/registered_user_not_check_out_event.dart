part of 'registered_user_not_check_out_bloc.dart';

sealed class RegisteredUserNotCheckOutEvent {
  const RegisteredUserNotCheckOutEvent();
}

final class GetRegisteredUserNotCheckOut
    extends RegisteredUserNotCheckOutEvent {}
