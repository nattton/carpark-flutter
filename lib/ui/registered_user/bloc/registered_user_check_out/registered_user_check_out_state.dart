part of 'registered_user_check_out_bloc.dart';

sealed class RegisteredUserCheckOutState extends Equatable {
  const RegisteredUserCheckOutState();

  @override
  List<Object> get props => [];
}

final class RegisteredUserCheckOutInitial extends RegisteredUserCheckOutState {}

final class RegisteredUserCheckOutLoading extends RegisteredUserCheckOutState {}

final class RegisteredUserCheckOutSuccess extends RegisteredUserCheckOutState {
  final RegisteredUser registeredUser;
  const RegisteredUserCheckOutSuccess({required this.registeredUser});

  @override
  List<Object> get props => [registeredUser];
}

final class RegisteredUserCheckOutFailure extends RegisteredUserCheckOutState {
  final Failure failure;
  const RegisteredUserCheckOutFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
