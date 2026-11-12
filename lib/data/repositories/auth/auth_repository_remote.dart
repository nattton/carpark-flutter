import 'package:carpark/data/models/login_request/login_request.dart';
import 'package:carpark/data/repositories/auth/auth_repository.dart';
import 'package:carpark/data/services/api/api_service.dart';
import 'package:carpark/data/services/local/shared_preferences_service.dart';
import 'package:carpark/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

const String authorizationHeader = 'Authorization';

@prod
@Singleton(as: AuthRepository)
class AuthRepositoryRemote extends AuthRepository {
  new({
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
        _dio.options.headers[authorizationHeader] = 'Bearer $_authToken';
        _isAuthenticated = result.value != null;
      case Error<String?>():
        _log.severe(
          'Failed to fetch Token from SharedPreferences',
          result.error,
        );
    }
  }

  @override
  Future<bool> get isAuthenticated async {
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
      final result = await _apiService.login(
        LoginRequest(username: username, password: password),
      );
      _log.info('User logged in');
      _isAuthenticated = true;
      _authToken = result.token;
      _dio.options.headers[authorizationHeader] = 'Bearer $_authToken';
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

      _authToken = null;
      _dio.options.headers.remove(authorizationHeader);
      _isAuthenticated = false;
      return result;
    } finally {
      notifyListeners();
    }
  }
}
