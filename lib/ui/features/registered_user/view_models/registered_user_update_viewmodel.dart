import 'package:carpark/data/models/registered_user/update_registered_user_request.dart';
import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/domain/models/null_time_model.dart';
import 'package:carpark/domain/models/registered_user.dart';
import 'package:carpark/domain/models/registered_user_model.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

enum RegisteredUserUpdateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
  updating,
  updateSuccess,
  updateFailure,
  selectingExpiredDate,
  selectExpiredDateSuccess,
  selectType,
  failure,
}

@Injectable()
class RegisteredUserUpdateViewModel extends ChangeNotifier {
  new({
    required RegisteredUserServiceRepository repository,
  }) : _repository = repository;

  final RegisteredUserServiceRepository _repository;

  RegisteredUserUpdateStatus status = RegisteredUserUpdateStatus.initial;
  RegisteredUser registeredUser = const RegisteredUser();
  String message = '';

  Future<Result<RegisteredUserModel>> getRegisteredUser(int id) async {
    status = RegisteredUserUpdateStatus.loading;
    notifyListeners();

    final result = await _repository.getRegisteredUser(id);
    switch (result) {
      case Ok<RegisteredUserModel>():
        status = RegisteredUserUpdateStatus.loadSuccess;
        registeredUser = result.value;
      case Error<RegisteredUserModel>():
        status = RegisteredUserUpdateStatus.loadFailure;
        message = result.error.toString();
    }
    notifyListeners();
    return result;
  }

  Future<Result<RegisteredUserModel>> updateRegisteredUser(
    UpdateRegisteredUserRequest request,
  ) async {
    status = RegisteredUserUpdateStatus.updating;
    notifyListeners();

    final result = await _repository.updateRegisteredUser(request);
    switch (result) {
      case Ok<RegisteredUserModel>():
        status = RegisteredUserUpdateStatus.updateSuccess;
        registeredUser = result.value;
      case Error<RegisteredUserModel>():
        status = RegisteredUserUpdateStatus.updateFailure;
        message = result.error.toString();
    }
    notifyListeners();
    return result;
  }

  void selectExpiredDate(List<DateTime?> expiredDates) {
    status = RegisteredUserUpdateStatus.selectingExpiredDate;
    notifyListeners();
    status = RegisteredUserUpdateStatus.selectExpiredDateSuccess;
    registeredUser = registeredUser.copyWith(
      expiredDate: NullTimeModel(valid: true, time: expiredDates[0]),
    );
    notifyListeners();
  }

  void selectType(String type) {
    status = RegisteredUserUpdateStatus.selectType;
    registeredUser = registeredUser.copyWith(type: type);
    notifyListeners();
  }
}
