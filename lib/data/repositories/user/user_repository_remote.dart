import 'package:carpark/data/models/login_response/user_model.dart';
import 'package:carpark/data/repositories/user/user_repository.dart';
import 'package:carpark/data/services/api/api_service.dart';
import 'package:carpark/domain/models/response_model.dart';
import 'package:carpark/domain/models/save_user_model.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserRepository)
class UserRepositoryRemote extends UserRepository {
  new({required ApiService apiService})
    : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<Result<List<UserModel>>> getUserList() async {
    try {
      final users = await _apiService.getUserList();
      return Result.ok(users);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<ResponseModel>> updateUser(SaveUserModel user) async {
    try {
      final response = await _apiService.updateUser(user.id, user);
      return Result.ok(response);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }
}
