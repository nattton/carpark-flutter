import 'package:carpark/data/services/api/model/registered_user/registered_user_logs_response.dart';
import 'package:carpark/domain/models/registered_user/registered_user_log_model.dart';
import 'package:carpark/domain/models/registered_user/registered_user_logs.dart';
import 'package:carpark/domain/models/registered_user/registered_user_model.dart';

class RegisteredUserLogsModel extends RegisteredUserLogs {
  const RegisteredUserLogsModel({required super.user, required super.logs});

  static RegisteredUserLogs responseMapper(
    RegisteredUserLogsResponse response,
  ) {
    return RegisteredUserLogs(
      user: RegisteredUserModel.responseMapper(response.registeredUser),
      logs: response.logs
          .map(RegisteredUserLogModel.responseMapper)
          .toList(),
    );
  }
}
