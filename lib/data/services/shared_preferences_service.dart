import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/result.dart';

class SharedPreferencesService {
  static const _tokenKey = 'TOKEN';
  static const _printerKey = 'PRINTER';
  final _log = Logger('SharedPreferencesService');

  Future<Result<String?>> fetchToken() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      _log.finer('Got token from SharedPreferences');
      return Result.ok(sharedPreferences.getString(_tokenKey));
    } on Exception catch (e) {
      _log.warning('Failed to get token', e);
      return Result.error(e);
    }
  }

  Future<Result<void>> saveToken(String? token) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (token == null) {
        _log.finer('Removed token');
        await sharedPreferences.remove(_tokenKey);
      } else {
        _log.finer('Replaced token');
        await sharedPreferences.setString(_tokenKey, token);
      }
      return const Result.ok(null);
    } on Exception catch (e) {
      _log.warning('Failed to set token', e);
      return Result.error(e);
    }
  }

  Future<Result<String?>> fetchPrinter() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      _log.finer('Got printer from SharedPreferences');
      return Result.ok(sharedPreferences.getString(_printerKey));
    } on Exception catch (e) {
      _log.warning('Failed to get printer', e);
      return Result.error(e);
    }
  }

  Future<Result<void>> savePrinter(String? printer) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (printer == null) {
        _log.finer('Removed printer');
        await sharedPreferences.remove(_printerKey);
      } else {
        _log.finer('Replaced printer');
        await sharedPreferences.setString(_printerKey, printer);
      }
      return const Result.ok(null);
    } on Exception catch (e) {
      _log.warning('Failed to set printer', e);
      return Result.error(e);
    }
  }
}
