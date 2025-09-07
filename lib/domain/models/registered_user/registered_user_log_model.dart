import 'package:carpark/data/services/api/model/registered_user/registered_user_logs_response.dart';
import 'package:carpark/domain/models/registered_user/registered_user_log.dart';
import 'package:carpark/domain/models/registered_user/registered_user_model.dart';

class RegisteredUserLogModel extends RegisteredUserLog {
  const RegisteredUserLogModel({
    required super.id,
    required super.checkInTime,
    required super.checkOutTime,
    required super.registeredUser,
  });

  static RegisteredUserLog responseMapper(RegisteredUserLogResponse response) {
    return RegisteredUserLog(
      id: response.id,
      checkInTime: response.checkInTime.valid ?? false
          ? response.checkInTime.time
          : null,
      checkOutTime: response.checkOutTime.valid ?? false
          ? response.checkOutTime.time
          : null,
      registeredUser: response.registeredUser != null
          ? RegisteredUserModel.responseMapper(response.registeredUser!)
          : null,
    );
  }

  static List<RegisteredUserLog> responseMapperNotCheckOutList(
    List<RegisteredUserLogResponse> response,
  ) {
    return response
        .map(RegisteredUserLogModel.responseMapper)
        .toList();
  }
}
