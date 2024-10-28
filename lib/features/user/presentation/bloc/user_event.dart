part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

final class Load extends UserEvent {
  const Load();
}

final class ClearError extends UserEvent {
  const ClearError();
}
