part of 'registered_user_logs_bloc.dart';

sealed class RegisteredUserLogsEvent {
  const RegisteredUserLogsEvent();
}

final class GetRegisteredUserLogs extends RegisteredUserLogsEvent {
  const GetRegisteredUserLogs({required this.userId});
  final int userId;
}
