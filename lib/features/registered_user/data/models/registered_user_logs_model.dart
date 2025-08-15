import '../../domain/entity/registered_user_logs.dart';
import '../../domain/models/registered_user_logs_response.dart';
import 'registered_user_log_model.dart';
import 'registered_user_model.dart';

class RegisteredUserLogsModel extends RegisteredUserLogs {
  const RegisteredUserLogsModel({required super.user, required super.logs});

  static RegisteredUserLogs responseMapper(
    RegisteredUserLogsResponse response,
  ) {
    return RegisteredUserLogs(
      user: RegisteredUserModel.responseMapper(response.registeredUser),
      logs: response.logs
          .map((e) => RegisteredUserLogModel.responseMapper(e))
          .toList(),
    );
  }
}
