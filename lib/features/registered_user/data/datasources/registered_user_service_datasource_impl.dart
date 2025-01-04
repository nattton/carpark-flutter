import 'dart:io';

import 'package:carpark/core/data/model/generic_response_data.dart';
import 'package:carpark/features/registered_user/data/datasources/registered_user_service_datasource.dart';
import 'package:carpark/features/registered_user/data/network/registered_user_service.dart';
import 'package:carpark/features/registered_user/domain/models/create_registered_user_request.dart';
import 'package:carpark/features/registered_user/domain/models/list_registered_user_param.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_check_in_request.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_check_out_request.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_log_response.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';
import 'package:carpark/features/registered_user/domain/models/update_registered_user_request.dart';

class RegisteredUserServiceDataSourceImpl
    extends RegisteredUserServiceDataSource {
  final RegisteredUserService registeredUserService;

  RegisteredUserServiceDataSourceImpl(this.registeredUserService);

  @override
  Future<GenericResponseData<RegisteredUserResponse>> addPhotoToRegisteredUser(
      String token, int id, File photo) {
    return registeredUserService.updatePhotoToRegisteredUser(token, id, photo);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> checkInRegisteredUser(
      String token, RegisteredUserCheckInRequest request) {
    return registeredUserService.checkInRegisteredUser(token, request);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> checkOutRegisteredUser(
      String token, RegisteredUserCheckOutRequest request) {
    return registeredUserService.checkOutRegisteredUser(token, request);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> createRegisteredUser(
      String token, CreateRegisteredUserRequest request) {
    return registeredUserService.createRegisteredUser(token, request);
  }

  @override
  Future<GenericResponseData<RegisteredUserLogResponse>> getRegisteredUserLogs(
      String token, String generatedId) {
    return registeredUserService.getRegisteredUserLogs(token, generatedId);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> updateRegisteredUser(
      String token, int id, UpdateRegisteredUserRequest request) {
    return registeredUserService.updateRegisteredUser(token, id, request);
  }

  @override
  Future<GenericResponseData<List<RegisteredUserResponse>>> getRegisteredUsers(
      String token, ListRegisteredUserParam param) {
    return registeredUserService.getRegisteredUsers(token, param.search);
  }
}
