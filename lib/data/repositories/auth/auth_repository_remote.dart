import '../../../utils/result.dart';

import 'auth_repository.dart';

class AuthRepositoryRemote extends AuthRepository {
  @override
  // TODO: implement isAuthenticated
  Future<bool> get isAuthenticated => throw UnimplementedError();

  @override
  Future<Result<void>> login({
    required String username,
    required String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
