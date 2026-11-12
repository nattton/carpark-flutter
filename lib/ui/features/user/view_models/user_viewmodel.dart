import 'package:carpark/data/models/login_response/user_model.dart';
import 'package:carpark/data/repositories/user/user_repository.dart';
import 'package:carpark/domain/models/response_model.dart';
import 'package:carpark/domain/models/save_user_model.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserViewModel extends ChangeNotifier {
  new({required UserRepository userRepository})
    : _userRepository = userRepository;

  final UserRepository _userRepository;

  List<UserModel> userList = <UserModel>[];

  Future<Result<List<UserModel>>> loadUsers() async {
    final result = await _userRepository.getUserList();
    if (result is Ok<List<UserModel>>) {
      userList = result.value;
      notifyListeners();
    }
    return result;
  }

  Future<Result<ResponseModel>> updateUser(SaveUserModel saveUser) async {
    final result = await _userRepository.updateUser(saveUser);
    if (result is Ok<ResponseModel>) {
      await loadUsers();
    }
    return result;
  }
}
