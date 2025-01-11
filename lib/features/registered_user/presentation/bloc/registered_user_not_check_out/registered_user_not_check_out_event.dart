part of 'registered_user_not_check_out_bloc.dart';

sealed class RegisteredUserNotCheckOutEvent extends Equatable {
  const RegisteredUserNotCheckOutEvent();

  @override
  List<Object> get props => [];
}

class GetRegisteredUserNotCheckOut extends RegisteredUserNotCheckOutEvent {}
