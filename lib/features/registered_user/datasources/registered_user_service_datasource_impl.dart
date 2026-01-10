import 'dart:io';

import 'package:carpark/features/registered_user/datasources/registered_user_service_datasource.dart';
import 'package:carpark/shared/services/api/model/registered_user/models.dart';
import 'package:carpark/shared/services/api/registered_user_service.dart';
import 'package:carpark/shared/utils/generic_response_data.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisteredUserServiceDataSource)
class RegisteredUserServiceDataSourceImpl
    extends RegisteredUserServiceDataSource {
  RegisteredUserServiceDataSourceImpl(this.registeredUserService);
  final RegisteredUserService registeredUserService;

  @override
  Future<GenericResponseData<RegisteredUserResponse>> addPhotoToRegisteredUser(
    int id,
    File photo,
  ) {
    return registeredUserService.addPhotoToRegisteredUser(id, photo);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> checkInRegisteredUser(
    RegisteredUserCheckInRequest request,
  ) {
    return registeredUserService.checkInRegisteredUser(request);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> checkOutRegisteredUser(
    RegisteredUserCheckOutRequest request,
  ) {
    return registeredUserService.checkOutRegisteredUser(request);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> createRegisteredUser(
    CreateRegisteredUserRequest request,
  ) {
    return registeredUserService.createRegisteredUser(request);
  }

  @override
  Future<GenericResponseData<RegisteredUserLogsResponse>> getRegisteredUserLogs(
    int id,
  ) {
    return registeredUserService.getRegisteredUserLogs(id);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> getRegisteredUser(
    int id,
  ) {
    return registeredUserService.getRegisteredUser(id);
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> updateRegisteredUser(
    int id,
    UpdateRegisteredUserRequest request,
  ) {
    return registeredUserService.updateRegisteredUser(id, request);
  }

  @override
  Future<GenericResponseData<List<RegisteredUserResponse>>> getRegisteredUsers(
    ListRegisteredUserParam param,
  ) {
    return registeredUserService.getRegisteredUsers(param.search);
  }

  @override
  Future<GenericResponseData<GetRegisteredUserLogNotCheckOutResponse>>
  getNotCheckOutRegisteredUser() {
    return registeredUserService.getNotCheckOutRegisteredUser();
  }
}
