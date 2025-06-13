import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/domain/entity/registered_user_log.dart';
import 'package:equatable/equatable.dart';

class RegisteredUserLogs extends Equatable {
  final RegisteredUser user;
  final RegisteredUserLogList logs;

  const RegisteredUserLogs({required this.user, required this.logs});

  @override
  List<Object?> get props => [user, logs];
}
