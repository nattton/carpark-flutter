import 'package:carpark/data/models/registered_user/registered_user_check_out_request.dart';
import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/domain/models/registered_user_model.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserCheckOutViewModel extends ChangeNotifier {
  new({
    required RegisteredUserServiceRepository repository,
  }) : _repository = repository;

  final RegisteredUserServiceRepository _repository;

  bool isLoading = false;
  String? errorMessage;
  RegisteredUserModel? registeredUser;

  Future<Result<RegisteredUserModel>> checkOut(String generatedId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _repository.checkOutRegisteredUser(
      RegisteredUserCheckOutRequest(generatedId: generatedId),
    );
    switch (result) {
      case Ok<RegisteredUserModel>():
        registeredUser = result.value;
      case Error<RegisteredUserModel>():
        errorMessage = result.error.toString();
    }
    isLoading = false;
    notifyListeners();
    return result;
  }
}
