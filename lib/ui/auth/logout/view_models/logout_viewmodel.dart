import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../../data/repositories/auth/auth_repository.dart';
import '../../../../utils/result.dart';

@injectable
class LogoutViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final _log = Logger('LogoutViewModel');

  late Command<void, Result<void>> logoutCommand;

  LogoutViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository {
    logoutCommand = Command.createAsync<void, Result<void>>(
      initialValue: Result.ok(null),
      (params) async {
        final result = await _authRepository.logout();
        if (result is Error<void>) {
          _log.warning('Logout failed! ${result.error}');
        }
        return result;
      },
    );
  }
}
