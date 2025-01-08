import 'dart:io';

import 'package:carpark/core/data/model/generic_response_data.dart';
import 'package:carpark/core/error/failures.dart';
import 'package:carpark/features/registered_user/domain/models/models.dart';
import 'package:fpdart/fpdart.dart';

abstract class RegisteredUserServiceRepository {
  Future<Either<Failure, GenericResponseData<IDCardResponse>>> readIdCard();

  Future<Either<Failure, GenericResponseData<List<RegisteredUserResponse>>>>
      getRegisteredUsers(ListRegisteredUserParam param);

  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      addPhotoToRegisteredUser(int id, File photo);

  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      checkInRegisteredUser(RegisteredUserCheckInRequest request);

  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      checkOutRegisteredUser(RegisteredUserCheckOutRequest request);

  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      createRegisteredUser(CreateRegisteredUserRequest request);

  Future<Either<Failure, GenericResponseData<RegisteredUserLogResponse>>>
      getRegisteredUserLogs(String generatedId);

  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      updateRegisteredUser(UpdateRegisteredUserRequest request);
}
