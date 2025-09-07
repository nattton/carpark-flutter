import 'package:carpark/data/repositories/auth/auth_repository.dart';
import 'package:carpark/utils/result.dart';
import 'package:injectable/injectable.dart';

@dev
@Singleton(as: AuthRepository)
class AuthRepositoryDev extends AuthRepository {
  /// User is always authenticated in dev scenarios
  @override
  Future<bool> get isAuthenticated => Future.value(true);

  /// Login is always successful in dev scenarios
  @override
  Future<Result<void>> login({
    required String username,
    required String password,
  }) async {
    return const Result.ok(null);
  }

  /// Logout is always successful in dev scenarios
  @override
  Future<Result<void>> logout() async {
    return const Result.ok(null);
  }
}
