import 'package:carpark/data/models/registered_user/list_registered_user_param.dart';
import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/domain/models/registered_user.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

enum RegisteredUserListMode { list, creating, updating }

@Injectable()
class RegisteredUserListViewModel extends ChangeNotifier {
  new({
    required RegisteredUserServiceRepository repository,
  }) : _repository = repository;

  final RegisteredUserServiceRepository _repository;

  RegisteredUserListMode mode = RegisteredUserListMode.list;
  bool isLoading = false;
  String? errorMessage;
  List<RegisteredUser> registeredUsers = <RegisteredUser>[];

  Future<Result<List<RegisteredUser>>> getRegisteredUserList() async {
    mode = RegisteredUserListMode.list;
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _repository.getRegisteredUsers(
      const ListRegisteredUserParam(search: ''),
    );
    switch (result) {
      case Ok<List<RegisteredUser>>():
        registeredUsers = result.value;
      case Error<List<RegisteredUser>>():
        errorMessage = result.error.toString();
    }
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Result<List<RegisteredUser>>> searchRegisteredUser(
    String searchText,
  ) async {
    mode = RegisteredUserListMode.list;
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _repository.getRegisteredUsers(
      ListRegisteredUserParam(search: searchText),
    );
    switch (result) {
      case Ok<List<RegisteredUser>>():
        registeredUsers = result.value;
      case Error<List<RegisteredUser>>():
        errorMessage = result.error.toString();
    }
    isLoading = false;
    notifyListeners();
    return result;
  }

  void startCreating() {
    mode = RegisteredUserListMode.creating;
    notifyListeners();
  }

  void startUpdating() {
    mode = RegisteredUserListMode.updating;
    notifyListeners();
  }
}
