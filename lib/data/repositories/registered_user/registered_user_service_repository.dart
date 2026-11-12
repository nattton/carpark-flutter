import 'dart:io';

import 'package:carpark/data/models/registered_user/models.dart';
import 'package:carpark/domain/models/models.dart';
import 'package:carpark/utils/result.dart';

abstract class RegisteredUserServiceRepository {
  Future<Result<List<RegisteredUser>>> getRegisteredUsers(
    ListRegisteredUserParam param,
  );

  Future<Result<RegisteredUserModel>> getRegisteredUser(int id);

  Future<Result<RegisteredUserModel>> addPhotoToRegisteredUser(
    int id,
    File photo,
  );

  Future<Result<RegisteredUserModel>> checkInRegisteredUser(
    RegisteredUserCheckInRequest request,
  );

  Future<Result<RegisteredUserModel>> checkOutRegisteredUser(
    RegisteredUserCheckOutRequest request,
  );

  Future<Result<RegisteredUserModel>> createRegisteredUser(
    CreateRegisteredUserRequest request,
  );

  Future<Result<RegisteredUserLogs>> getRegisteredUserLogs(int id);

  Future<Result<RegisteredUserModel>> updateRegisteredUser(
    UpdateRegisteredUserRequest request,
  );

  Future<Result<List<RegisteredUserLog>>> getNotCheckOutRegisteredUser();
}
