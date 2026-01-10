import 'package:carpark/features/registered_user/models/registered_user_log_model.dart';
import 'package:carpark/features/registered_user/models/registered_user_logs.dart';
import 'package:carpark/features/registered_user/models/registered_user_model.dart';
import 'package:carpark/shared/services/api/model/registered_user/registered_user_logs_response.dart';

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
