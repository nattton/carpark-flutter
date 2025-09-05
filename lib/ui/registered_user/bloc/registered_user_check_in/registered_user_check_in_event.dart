part of 'registered_user_check_in_bloc.dart';

sealed class RegisteredUserCheckInEvent extends Equatable {
  const RegisteredUserCheckInEvent();

  @override
  List<Object> get props => [];
}

class PostRegisteredUserCheckInEvent extends RegisteredUserCheckInEvent {
  final String generatedId;
  const PostRegisteredUserCheckInEvent({required this.generatedId});

  @override
  List<Object> get props => [generatedId];
}
