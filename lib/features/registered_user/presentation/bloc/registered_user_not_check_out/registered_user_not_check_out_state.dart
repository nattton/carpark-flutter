part of 'registered_user_not_check_out_bloc.dart';

sealed class RegisteredUserNotCheckOutState extends Equatable {
  const RegisteredUserNotCheckOutState();

  @override
  List<Object> get props => [];
}

final class RegisteredUserNotCheckOutInitial
    extends RegisteredUserNotCheckOutState {}

final class RegisteredUserNotCheckOutLoading
    extends RegisteredUserNotCheckOutState {}

final class RegisteredUserNotCheckOutLoaded
    extends RegisteredUserNotCheckOutState {
  final List<RegisteredUserLog> registeredUserLog;

  const RegisteredUserNotCheckOutLoaded(this.registeredUserLog);
}

final class RegisteredUserNotCheckOutError
    extends RegisteredUserNotCheckOutState {
  final Failure failure;

  const RegisteredUserNotCheckOutError(this.failure);
}
