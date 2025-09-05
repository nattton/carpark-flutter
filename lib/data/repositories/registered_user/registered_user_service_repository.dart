import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../utils/failures.dart';
import '../../../utils/generic_response_data.dart';
import '../../services/api/model/registered_user/models.dart';

abstract class RegisteredUserServiceRepository {
  Future<Either<Failure, GenericResponseData<List<RegisteredUserResponse>>>>
  getRegisteredUsers(ListRegisteredUserParam param);

  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
  getRegisteredUser(int id);

  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
  addPhotoToRegisteredUser(int id, File photo);

  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
  checkInRegisteredUser(RegisteredUserCheckInRequest request);

  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
  checkOutRegisteredUser(RegisteredUserCheckOutRequest request);

  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
  createRegisteredUser(CreateRegisteredUserRequest request);

  Future<Either<Failure, GenericResponseData<RegisteredUserLogsResponse>>>
  getRegisteredUserLogs(int id);

  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
  updateRegisteredUser(UpdateRegisteredUserRequest request);

  Future<
    Either<
      Failure,
      GenericResponseData<GetRegisteredUserLogNotCheckOutResponse>
    >
  >
  getNotCheckOutRegisteredUser();
}
