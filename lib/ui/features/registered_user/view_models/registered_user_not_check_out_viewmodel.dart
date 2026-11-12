import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/domain/models/registered_user_log.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserNotCheckOutViewModel extends ChangeNotifier {
  new({
    required RegisteredUserServiceRepository repository,
  }) : _repository = repository;

  final RegisteredUserServiceRepository _repository;

  bool isLoading = false;
  String? errorMessage;
  List<RegisteredUserLog> registeredUserLogs = <RegisteredUserLog>[];

  Future<Result<List<RegisteredUserLog>>> getRegisteredUserNotCheckOut() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _repository.getNotCheckOutRegisteredUser();
    switch (result) {
      case Ok<List<RegisteredUserLog>>():
        registeredUserLogs = result.value;
      case Error<List<RegisteredUserLog>>():
        errorMessage = result.error.toString();
    }
    isLoading = false;
    notifyListeners();
    return result;
  }
}
