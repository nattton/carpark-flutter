import 'package:carpark/domain/models/registered_user/registered_user.dart';
import 'package:carpark/domain/models/registered_user/registered_user_log.dart';
import 'package:equatable/equatable.dart';

class RegisteredUserLogs extends Equatable {

  const RegisteredUserLogs({required this.user, required this.logs});
  final RegisteredUser user;
  final RegisteredUserLogList logs;

  @override
  List<Object?> get props => [user, logs];
}
