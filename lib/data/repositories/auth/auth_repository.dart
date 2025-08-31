import 'package:flutter/foundation.dart';

import '../../../utils/result.dart';

abstract class AuthRepository extends ChangeNotifier {
  /// Returns true when the user is logged in Returens [Future] because it will load a stored auth state the first time.
  Future<bool> get isAuthenticated;

  Future<Result<void>> login({
    required String username,
    required String password,
  });

  Future<Result<void>> logout();
}
