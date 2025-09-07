import 'package:carpark/data/repositories/auth/auth_repository.dart';
import 'package:carpark/utils/result.dart';
import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class LoginViewModel extends ChangeNotifier {

  LoginViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository {
    loginCommand =
        Command.createAsync<(String username, String password), Result<void>>(
          initialValue: const Result.ok(null),
          (params) async {
            final (username, password) = params;
            final result = await _authRepository.login(
              username: username,
              password: password,
            );
            if (result is Error<void>) {
              _log.warning('Login failed! ${result.error}');
            }
            return result;
          },
        );
  }
  final AuthRepository _authRepository;
  final _log = Logger('LoginViewModel');

  late Command<(String, String), Result<void>> loginCommand;
}
