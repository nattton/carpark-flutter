import 'package:equatable/equatable.dart';

import 'registered_user.dart';
import 'registered_user_log.dart';

class RegisteredUserLogs extends Equatable {
  final RegisteredUser user;
  final RegisteredUserLogList logs;

  const RegisteredUserLogs({required this.user, required this.logs});

  @override
  List<Object?> get props => [user, logs];
}
