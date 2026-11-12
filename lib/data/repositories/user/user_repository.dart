import 'package:carpark/data/models/login_response/user_model.dart';
import 'package:carpark/domain/models/response_model.dart';
import 'package:carpark/domain/models/save_user_model.dart';
import 'package:carpark/utils/result.dart';

abstract class UserRepository {
  Future<Result<List<UserModel>>> getUserList();
  Future<Result<ResponseModel>> updateUser(SaveUserModel user);
}
