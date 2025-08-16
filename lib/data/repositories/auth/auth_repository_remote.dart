import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../../utils/result.dart';
import '../../services/api/api_service.dart';
import '../../services/shared_preferences_service.dart';
import 'auth_repository.dart';

class AuthRepositoryRemote extends AuthRepository {
  AuthRepositoryRemote({
    required Dio dio,
    required ApiService apiService,
    required SharedPreferencesService sharedPreferencesService,
  }) : _dio = dio,
       _apiService = apiService,
       _sharedPreferencesService = sharedPreferencesService;

  final Dio _dio;
  final ApiService _apiService;
  final SharedPreferencesService _sharedPreferencesService;

  bool? _isAuthenticated;
  String? _authToken;
  final _log = Logger('AuthRepositoryRemote');

  Future<void> _fetch() async {
    final result = await _sharedPreferencesService.fetchToken();
    switch (result) {
      case Ok<String?>():
        _authToken = result.value;
        _dio.options.headers['Authorization'] = 'Bearer ${result.value}';
        _isAuthenticated = result.value != null;
      case Error<String?>():
        _log.severe(
          'Failed to fech Token from SharedPreferences',
          result.error,
        );
    }
  }

  @override
  Future<bool> get isAuthenticated async {
    // Status is cached
    if (_isAuthenticated != null) {
      return _isAuthenticated!;
    }

    await _fetch();
    return _isAuthenticated ?? false;
  }

  @override
  Future<Result<void>> login({
    required String username,
    required String password,
  }) async {
    try {
      final result = await _apiService.login(username, password);
      _log.info('User logged in');
      // Set auth status
      _isAuthenticated = true;
      _authToken = result.token;
      _dio.options.headers['Authorization'] = 'Bearer ${result.token}';
      return await _sharedPreferencesService.saveToken(result.token);
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> logout() async {
    _log.info('User logged out');
    try {
      final result = await _sharedPreferencesService.saveToken(null);
      if (result is Error<void>) {
        _log.severe('Failed to clear stored auth token');
      }

      // Clear token in ApiClient
      _authToken = null;
      _dio.options.headers['Authorization'] = null;
      // Clear authenticated status
      _isAuthenticated = false;
      return result;
    } finally {
      notifyListeners();
    }
  }
}
