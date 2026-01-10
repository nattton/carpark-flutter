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

  const RegisteredUserNotCheckOutLoaded(this.registeredUserLog);
  final List<RegisteredUserLog> registeredUserLog;
}

final class RegisteredUserNotCheckOutError
    extends RegisteredUserNotCheckOutState {

  const RegisteredUserNotCheckOutError(this.failure);
  final Failure failure;
}
