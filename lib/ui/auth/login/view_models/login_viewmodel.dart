import 'package:carpark/data/repositories/auth/auth_repository.dart';
import 'package:carpark/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@singleton
class LoginViewModel {
  LoginViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository;
  final AuthRepository _authRepository;
  final _log = Logger('LoginViewModel');

  late final Command<String, String> usernameChangedCommand =
      Command.createSync<String, String>(
        initialValue: '',
        (s) => s,
      );
  late final Command<String, String> passwordChangedCommand =
      Command.createSync<String, String>(
        initialValue: '',
        (s) => s,
      );
  late final Command<bool, bool> obscurePasswordChangedCommand =
      Command.createSync<bool, bool>(
        initialValue: true,
        (s) => s,
      );

  late final Command<void, Result<void>> loginCommand =
      Command.createAsyncNoParam<Result<void>>(
        initialValue: const Result.ok(null),
        () async {
          final usernameValue = usernameChangedCommand.value;
          final passwordValue = passwordChangedCommand.value;
          if (usernameValue.isEmpty || passwordValue.isEmpty) {
            throw Exception('Username and password are required');
          }

          if (usernameValue.length < 3 || passwordValue.length < 3) {
            throw Exception(
              'Username and password must be at least 3 characters',
            );
          }

          final result = await _authRepository.login(
            username: usernameValue,
            password: passwordValue,
          );
          if (result is Error<void>) {
            _log.warning('Login failed! ${result.error}');
            final error = result.error;
            if (error is DioException) {
              if (error.response?.data is Map) {
                final res = error.response?.data as Map;
                throw Exception(res['message']);
              }
              throw error;
            }
            throw result.error;
          }
          usernameChangedCommand('');
          passwordChangedCommand('');
          obscurePasswordChangedCommand(true);
          return result;
        },
      );
}
