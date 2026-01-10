part of 'registered_user_check_in_bloc.dart';

sealed class RegisteredUserCheckInState extends Equatable {
  const RegisteredUserCheckInState();

  @override
  List<Object> get props => [];
}

final class RegisteredUserCheckInInitial extends RegisteredUserCheckInState {}

final class RegisteredUserCheckInLoading extends RegisteredUserCheckInState {}

final class RegisteredUserCheckInSuccess extends RegisteredUserCheckInState {
  const RegisteredUserCheckInSuccess({required this.registeredUser});
  final RegisteredUser registeredUser;

  @override
  List<Object> get props => [registeredUser];
}

final class RegisteredUserCheckInFailure extends RegisteredUserCheckInState {
  const RegisteredUserCheckInFailure({required this.failure});
  final Failure failure;

  @override
  List<Object> get props => [failure];
}
