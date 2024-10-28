part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

final class Load extends UserEvent {
  const Load();
}

class Update extends UserEvent {
  final int id;
  final String username;
  final String password;
  final String role;

  const Update({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
  });

  @override
  List<Object> get props => [id, username, password, role];
}

final class ClearError extends UserEvent {
  const ClearError();
}
