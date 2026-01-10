import 'package:carpark/shared/repositories/auth/auth_repository.dart';
import 'package:carpark/shared/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@singleton
class LogoutViewModel extends ChangeNotifier {
  LogoutViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository {
    logoutCommand = Command.createAsync<void, Result<void>>(
      initialValue: const Result.ok(null),
      (params) async {
        final result = await _authRepository.logout();
        if (result is Error<void>) {
          _log.warning('Logout failed! ${result.error}');
        }
        return result;
      },
    );
  }
  final AuthRepository _authRepository;
  final _log = Logger('LogoutViewModel');

  late Command<void, Result<void>> logoutCommand;
}
