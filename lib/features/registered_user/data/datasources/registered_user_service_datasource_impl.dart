import 'dart:io';

import 'package:carpark/core/data/model/generic_response_data.dart';
import 'package:carpark/features/registered_user/data/datasources/registered_user_service_datasource.dart';
import 'package:carpark/features/registered_user/data/network/registered_user_service.dart';
import 'package:carpark/features/registered_user/domain/models/models.dart';
import 'package:carpark/services/app_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisteredUserServiceDataSource)
class RegisteredUserServiceDataSourceImpl
    extends RegisteredUserServiceDataSource {
  final RegisteredUserService registeredUserService;
  final AppService appService;

  RegisteredUserServiceDataSourceImpl(
      this.registeredUserService, this.appService);

  @override
  Future<GenericResponseData<IDCardResponse>> readIdCard() {
    return registeredUserService.readIdCard();
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> addPhotoToRegisteredUser(
      int id, File photo) {
    return registeredUserService.addPhotoToRegisteredUser(
        appService.token, id, photo);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> checkInRegisteredUser(
      RegisteredUserCheckInRequest request) {
    return registeredUserService.checkInRegisteredUser(
        appService.token, request);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> checkOutRegisteredUser(
      RegisteredUserCheckOutRequest request) {
    return registeredUserService.checkOutRegisteredUser(
        appService.token, request);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> createRegisteredUser(
      CreateRegisteredUserRequest request) {
    return registeredUserService.createRegisteredUser(
        appService.token, request);
  }

  @override
  Future<GenericResponseData<RegisteredUserLogResponse>> getRegisteredUserLogs(
      String generatedId) {
    return registeredUserService.getRegisteredUserLogs(
        appService.token, generatedId);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> getRegisteredUser(
      int id) {
    return registeredUserService.getRegisteredUser(appService.token, id);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> updateRegisteredUser(
      int id, UpdateRegisteredUserRequest request) {
    return registeredUserService.updateRegisteredUser(
        appService.token, id, request);
  }

  @override
  Future<GenericResponseData<List<RegisteredUserResponse>>> getRegisteredUsers(
      ListRegisteredUserParam param) {
    return registeredUserService.getRegisteredUsers(
        appService.token, param.search);
  }
}
