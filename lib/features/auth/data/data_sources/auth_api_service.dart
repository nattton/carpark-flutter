import 'package:carpark/features/auth/data/models/login_request_model.dart';
import 'package:carpark/features/auth/data/models/user_login_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST("/api/login")
  Future<UserLoginModel> login(@Body() LoginRequestModel login);
}
