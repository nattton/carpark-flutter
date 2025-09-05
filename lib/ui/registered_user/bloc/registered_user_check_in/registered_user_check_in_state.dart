part of 'registered_user_check_in_bloc.dart';

sealed class RegisteredUserCheckInState extends Equatable {
  const RegisteredUserCheckInState();

  @override
  List<Object> get props => [];
}

final class RegisteredUserCheckInInitial extends RegisteredUserCheckInState {}

final class RegisteredUserCheckInLoading extends RegisteredUserCheckInState {}

final class RegisteredUserCheckInSuccess extends RegisteredUserCheckInState {
  final RegisteredUser registeredUser;
  const RegisteredUserCheckInSuccess({required this.registeredUser});

  @override
  List<Object> get props => [registeredUser];
}

final class RegisteredUserCheckInFailure extends RegisteredUserCheckInState {
  final Failure failure;
  const RegisteredUserCheckInFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
