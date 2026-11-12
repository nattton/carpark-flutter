import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/domain/models/registered_user.dart';
import 'package:carpark/domain/models/registered_user_log.dart';
import 'package:carpark/domain/models/registered_user_logs.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserLogsViewModel extends ChangeNotifier {
  new({
    required RegisteredUserServiceRepository repository,
  }) : _repository = repository;

  final RegisteredUserServiceRepository _repository;

  bool isLoading = false;
  String? errorMessage;
  RegisteredUser? user;
  RegisteredUserLogList logs = <RegisteredUserLog>[];

  Future<Result<RegisteredUserLogs>> getRegisteredUserLogs(int userId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _repository.getRegisteredUserLogs(userId);
    switch (result) {
      case Ok<RegisteredUserLogs>():
        user = result.value.user;
        logs = result.value.logs;
      case Error<RegisteredUserLogs>():
        errorMessage = result.error.toString();
    }
    isLoading = false;
    notifyListeners();
    return result;
  }
}
