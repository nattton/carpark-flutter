import 'package:carpark/features/registered_user/domain/entity/registered_user_log.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_logs_response.dart';

class RegisteredUserLogsMapper {
  static List<RegisteredUserLog> responseMapper(
      List<RegisteredUserLogResponse> response) {
    return response
        .map((e) => RegisteredUserLogMapper.responseMapper(e))
        .toList();
  }
}

class RegisteredUserLogMapper {
  static RegisteredUserLog responseMapper(RegisteredUserLogResponse response) {
    return RegisteredUserLog(
      id: response.id,
      checkInTime: response.checkInTime.time,
      checkOutTime: response.checkOutTime.time,
    );
  }
}
