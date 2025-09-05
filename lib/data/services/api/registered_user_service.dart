import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../utils/generic_response_data.dart';
import 'model/registered_user/models.dart';

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
    @Query('search') String searchText,
  );

  @GET('/api/registered-users/{id}')
  Future<GenericResponseData<RegisteredUserResponse>> getRegisteredUser(
    @Path() int id,
  );

  @POST('/api/registered-users')
  Future<GenericResponseData<RegisteredUserResponse>> createRegisteredUser(
    @Body() CreateRegisteredUserRequest request,
  );

  @PATCH('/api/registered-users/{id}/photo')
  Future<GenericResponseData<RegisteredUserResponse>> addPhotoToRegisteredUser(
    @Path() int id,
    @Part() File photo,
  );

  @PATCH('/api/registered-users/{id}')
  Future<GenericResponseData<RegisteredUserResponse>> updateRegisteredUser(
    @Path() int id,
    @Body() UpdateRegisteredUserRequest request,
  );

  @POST('/api/registered-users-logs/check-in')
  Future<GenericResponseData<RegisteredUserResponse>> checkInRegisteredUser(
    @Body() RegisteredUserCheckInRequest request,
  );

  @POST('/api/registered-users-logs/check-out')
  Future<GenericResponseData<RegisteredUserResponse>> checkOutRegisteredUser(
    @Body() RegisteredUserCheckOutRequest request,
  );

  @GET('/api/registered-users-logs/{id}')
  Future<GenericResponseData<RegisteredUserLogsResponse>> getRegisteredUserLogs(
    @Path() int id,
  );

  @GET('/api/registered-users-logs/not-check-out')
  Future<GenericResponseData<GetRegisteredUserLogNotCheckOutResponse>>
  getNotCheckOutRegisteredUser();
}
