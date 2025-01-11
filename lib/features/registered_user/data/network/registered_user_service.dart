import 'dart:io';

import 'package:carpark/core/data/model/generic_response_data.dart';
import 'package:carpark/features/registered_user/domain/models/models.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'registered_user_service.g.dart';

@module
abstract class RegisteredUserServiceModule {
  @singleton
  RegisteredUserService create(Dio dio) => RegisteredUserService(dio);
}

@RestApi()
abstract class RegisteredUserService {
  factory RegisteredUserService(Dio dio) = _RegisteredUserService;

  @GET('/api/registered-users')
  Future<GenericResponseData<List<RegisteredUserResponse>>> getRegisteredUsers(
      @Header('Authorization') String token,
      @Query('search') String searchText);

  @GET('/api/registered-users/{id}')
  Future<GenericResponseData<RegisteredUserResponse>> getRegisteredUser(
      @Header('Authorization') String token, @Path() int id);

  @POST('/api/registered-users')
  Future<GenericResponseData<RegisteredUserResponse>> createRegisteredUser(
      @Header('Authorization') String token,
      @Body() CreateRegisteredUserRequest request);

  @PATCH('/api/registered-users/{id}/photo')
  Future<GenericResponseData<RegisteredUserResponse>> addPhotoToRegisteredUser(
      @Header('Authorization') String token,
      @Path() int id,
      @Part() File photo);

  @PATCH('/api/registered-users/{id}')
  Future<GenericResponseData<RegisteredUserResponse>> updateRegisteredUser(
      @Header('Authorization') String token,
      @Path() int id,
      @Body() UpdateRegisteredUserRequest request);

  @POST('/api/registered-users-logs/check-in')
  Future<GenericResponseData<RegisteredUserResponse>> checkInRegisteredUser(
      @Header('Authorization') String token,
      @Body() RegisteredUserCheckInRequest request);

  @POST('/api/registered-users-logs/check-out')
  Future<GenericResponseData<RegisteredUserResponse>> checkOutRegisteredUser(
      @Header('Authorization') String token,
      @Body() RegisteredUserCheckOutRequest request);

  @GET('/api/registered-users-logs/{id}')
  Future<GenericResponseData<RegisteredUserLogsResponse>> getRegisteredUserLogs(
      @Header('Authorization') String token, @Path() int id);

  @GET('/api/registered-users-logs/not-check-out')
  Future<GenericResponseData<GetRegisteredUserLogNotCheckOutResponse>>
      getNotCheckOutRegisteredUser(@Header('Authorization') String token);
}
