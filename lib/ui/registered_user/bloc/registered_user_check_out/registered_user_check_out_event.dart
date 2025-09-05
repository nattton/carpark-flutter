part of 'registered_user_check_out_bloc.dart';

sealed class RegisteredUserCheckOutEvent extends Equatable {
  const RegisteredUserCheckOutEvent();

  @override
  List<Object> get props => [];
}

final class PostRegisteredUserCheckOutEvent
    extends RegisteredUserCheckOutEvent {
  final String generatedId;
  const PostRegisteredUserCheckOutEvent({required this.generatedId});

  @override
  List<Object> get props => [generatedId];
}
