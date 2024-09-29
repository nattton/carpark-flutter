import 'package:carpark/core/error/failures.dart';
import 'package:carpark/features/auth/data/data_sources/auth_api_service.dart';
import 'package:carpark/features/auth/data/models/login_request_model.dart';
import 'package:carpark/features/auth/data/models/user_login_model.dart';
import 'package:carpark/features/auth/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService authApiService;

  AuthRepositoryImpl({
    required this.authApiService,
  });

  @override
  Future<Either<Failure, UserLoginModel>> loginWithUsernamePassword(
      {required String username, required String password}) async {
    try {
      final res = await authApiService.login(
        LoginRequestModel(
          username: username,
          password: password,
        ),
      );
      return right(res);
    } on DioException catch (e) {
      return left(Failure.fromMap(e.response!.data));
    }
  }
}
