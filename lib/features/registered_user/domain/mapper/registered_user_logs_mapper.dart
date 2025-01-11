import 'package:carpark/features/registered_user/domain/entity/registered_user_logs.dart';
import 'package:carpark/features/registered_user/domain/mapper/registered_user_log_mapper.dart';
import 'package:carpark/features/registered_user/domain/mapper/registered_user_mapper.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_logs_response.dart';

class RegisteredUserLogsMapper {
  static RegisteredUserLogs responseMapper(
      RegisteredUserLogsResponse response) {
    return RegisteredUserLogs(
        RegisteredUserMapper.responseMapper(response.registeredUser),
        response.logs
            .map((e) => RegisteredUserLogMapper.responseMapper(e))
            .toList());
  }
}
