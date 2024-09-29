import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/usecase/usercase.dart';
import 'package:carpark/features/auth/data/models/user_login_model.dart';
import 'package:carpark/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<UserLoginModel, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, UserLoginModel>> call(UserLoginParams params) async {
    return await authRepository.loginWithUsernamePassword(
      username: params.username,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String username;
  final String password;

  UserLoginParams({
    required this.username,
    required this.password,
  });
}
