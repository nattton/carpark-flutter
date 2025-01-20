import 'package:carpark/features/registered_user/domain/entity/registered_user_log.dart';
import 'package:carpark/features/registered_user/domain/mapper/registered_user_mapper.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_logs_response.dart';

class RegisteredUserLogMapper {
  static RegisteredUserLog responseMapper(RegisteredUserLogResponse response) {
    return RegisteredUserLog(
        id: response.id,
        checkInTime: response.checkInTime.valid == true
            ? response.checkInTime.time
            : null,
        checkOutTime: response.checkOutTime.valid == true
            ? response.checkOutTime.time
            : null,
        registeredUser: response.registeredUser != null
            ? RegisteredUserMapper.responseMapper(response.registeredUser!)
            : null);
  }

  static List<RegisteredUserLog> responseMapperNotCheckOutList(
      List<RegisteredUserLogResponse> response) {
    return response
        .map((e) => RegisteredUserLogMapper.responseMapper(e))
        .toList();
  }
}
