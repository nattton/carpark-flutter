import 'package:carpark/core/error/failures.dart';
import 'package:carpark/features/auth/data/models/user_login_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserLoginModel>> loginWithUsernamePassword({
    required String username,
    required String password,
  });
}
