import 'dart:io';

import 'package:carpark/core/data/model/generic_response_data.dart';
import 'package:carpark/features/registered_user/domain/models/models.dart';

abstract class RegisteredUserServiceDataSource {
  Future<GenericResponseData<IDCardResponse>> readIdCard();

  Future<GenericResponseData<List<RegisteredUserResponse>>> getRegisteredUsers(
      String token, ListRegisteredUserParam param);

  Future<GenericResponseData<RegisteredUserResponse>> getRegisteredUser(
      String token, int id);

  Future<GenericResponseData<RegisteredUserResponse>> addPhotoToRegisteredUser(
      String token, int id, File photo);

  Future<GenericResponseData<RegisteredUserResponse>> checkInRegisteredUser(
      String token, RegisteredUserCheckInRequest request);

  Future<GenericResponseData<RegisteredUserResponse>> checkOutRegisteredUser(
      String token, RegisteredUserCheckOutRequest request);

  Future<GenericResponseData<RegisteredUserResponse>> createRegisteredUser(
      String token, CreateRegisteredUserRequest request);

  Future<GenericResponseData<RegisteredUserLogResponse>> getRegisteredUserLogs(
      String token, String generatedId);

  Future<GenericResponseData<RegisteredUserResponse>> updateRegisteredUser(
      String token, int id, UpdateRegisteredUserRequest request);
}
