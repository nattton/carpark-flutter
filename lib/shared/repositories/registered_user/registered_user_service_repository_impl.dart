import 'dart:io';

import 'package:carpark/features/registered_user/datasources/registered_user_service_datasource.dart';
import 'package:carpark/shared/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/shared/services/api/model/registered_user/models.dart';
import 'package:carpark/shared/utils/failures.dart';
import 'package:carpark/shared/utils/generic_response_data.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisteredUserServiceRepository)
class RegisteredUserServiceRepositoryImpl
    extends RegisteredUserServiceRepository {
  RegisteredUserServiceRepositoryImpl(this.dataSource);
  final RegisteredUserServiceDataSource dataSource;

  @override
  Future<Either<Failure, GenericResponseData<List<RegisteredUserResponse>>>>
  getRegisteredUsers(ListRegisteredUserParam param) async {
    return TaskEither.tryCatch(
      () => dataSource.getRegisteredUsers(param),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
  getRegisteredUser(int id) async {
    return TaskEither.tryCatch(
      () => dataSource.getRegisteredUser(id),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
  addPhotoToRegisteredUser(int id, File photo) async {
    return TaskEither.tryCatch(
      () => dataSource.addPhotoToRegisteredUser(id, photo),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
  checkInRegisteredUser(RegisteredUserCheckInRequest request) async {
    return TaskEither.tryCatch(
      () => dataSource.checkInRegisteredUser(request),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
  checkOutRegisteredUser(RegisteredUserCheckOutRequest request) async {
    return TaskEither.tryCatch(
      () => dataSource.checkOutRegisteredUser(request),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
  createRegisteredUser(CreateRegisteredUserRequest request) async {
    return TaskEither.tryCatch(
      () => dataSource.createRegisteredUser(request),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserLogsResponse>>>
  getRegisteredUserLogs(int id) async {
    return TaskEither.tryCatch(
      () => dataSource.getRegisteredUserLogs(id),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
  updateRegisteredUser(UpdateRegisteredUserRequest request) async {
    return TaskEither.tryCatch(
      () => dataSource.updateRegisteredUser(request.id, request),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<
    Either<
      Failure,
      GenericResponseData<GetRegisteredUserLogNotCheckOutResponse>
    >
  >
  getNotCheckOutRegisteredUser() async {
    return TaskEither.tryCatch(
      dataSource.getNotCheckOutRegisteredUser,
      (e, _) => Failure.fromException(e),
    ).run();
  }
}
