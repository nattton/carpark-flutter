part of 'registered_user_logs_bloc.dart';

sealed class RegisteredUserLogsEvent extends Equatable {
  const RegisteredUserLogsEvent();

  @override
  List<Object> get props => [];
}

class GetRegisteredUserLogs extends RegisteredUserLogsEvent {
  const GetRegisteredUserLogs({required this.userId});
  final int userId;

  @override
  List<Object> get props => [userId];
}
