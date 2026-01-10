import 'dart:io';

import 'package:carpark/shared/services/api/model/registered_user/models.dart';
import 'package:carpark/shared/utils/generic_response_data.dart';

abstract class RegisteredUserServiceDataSource {
  Future<GenericResponseData<List<RegisteredUserResponse>>> getRegisteredUsers(
    ListRegisteredUserParam param,
  );

  Future<GenericResponseData<RegisteredUserResponse>> getRegisteredUser(int id);

  Future<GenericResponseData<RegisteredUserResponse>> addPhotoToRegisteredUser(
    int id,
    File photo,
  );

  Future<GenericResponseData<RegisteredUserResponse>> checkInRegisteredUser(
    RegisteredUserCheckInRequest request,
  );

  Future<GenericResponseData<RegisteredUserResponse>> checkOutRegisteredUser(
    RegisteredUserCheckOutRequest request,
  );

  Future<GenericResponseData<RegisteredUserResponse>> createRegisteredUser(
    CreateRegisteredUserRequest request,
  );

  Future<GenericResponseData<RegisteredUserLogsResponse>> getRegisteredUserLogs(
    int id,
  );

  Future<GenericResponseData<RegisteredUserResponse>> updateRegisteredUser(
    int id,
    UpdateRegisteredUserRequest request,
  );

  Future<GenericResponseData<GetRegisteredUserLogNotCheckOutResponse>>
  getNotCheckOutRegisteredUser();
}
