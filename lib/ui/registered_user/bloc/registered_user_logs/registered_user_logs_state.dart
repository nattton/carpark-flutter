part of 'registered_user_logs_bloc.dart';

sealed class RegisteredUserLogsState extends Equatable {
  const RegisteredUserLogsState();

  @override
  List<Object> get props => [];
}

final class RegisteredUserLogsInitial extends RegisteredUserLogsState {}

final class RegisteredUserLogsLoading extends RegisteredUserLogsState {}

final class RegisteredUserLogsSuccess extends RegisteredUserLogsState {
  const RegisteredUserLogsSuccess(this.user, this.logs);
  final RegisteredUser user;
  final RegisteredUserLogList logs;

  @override
  List<Object> get props => [user, logs];
}

final class RegisteredUserLogsFailure extends RegisteredUserLogsState {
  const RegisteredUserLogsFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
