part of 'registered_user_check_in_bloc.dart';

sealed class RegisteredUserCheckInEvent extends Equatable {
  const RegisteredUserCheckInEvent();

  @override
  List<Object> get props => [];
}

class PostRegisteredUserCheckInEvent extends RegisteredUserCheckInEvent {
  const PostRegisteredUserCheckInEvent({required this.generatedId});
  final String generatedId;

  @override
  List<Object> get props => [generatedId];
}
