part of 'registered_user_check_out_bloc.dart';

sealed class RegisteredUserCheckOutEvent {
  const RegisteredUserCheckOutEvent();
}

final class PostRegisteredUserCheckOutEvent
    extends RegisteredUserCheckOutEvent {
  const PostRegisteredUserCheckOutEvent({required this.generatedId});
  final String generatedId;
}
