part of 'registered_user_check_out_bloc.dart';

sealed class RegisteredUserCheckOutState extends Equatable {
  const RegisteredUserCheckOutState();

  @override
  List<Object> get props => [];
}

final class RegisteredUserCheckOutInitial extends RegisteredUserCheckOutState {}

final class RegisteredUserCheckOutLoading extends RegisteredUserCheckOutState {}

final class RegisteredUserCheckOutSuccess extends RegisteredUserCheckOutState {
  const RegisteredUserCheckOutSuccess({required this.registeredUser});
  final RegisteredUser registeredUser;

  @override
  List<Object> get props => [registeredUser];
}

final class RegisteredUserCheckOutFailure extends RegisteredUserCheckOutState {
  const RegisteredUserCheckOutFailure({required this.failure});
  final Failure failure;

  @override
  List<Object> get props => [failure];
}
