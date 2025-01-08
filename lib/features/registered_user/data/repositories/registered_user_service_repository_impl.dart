import 'dart:io';

import 'package:carpark/core/data/model/generic_response_data.dart';
import 'package:carpark/core/error/failures.dart';
import 'package:carpark/features/registered_user/data/datasources/registered_user_service_datasource.dart';
import 'package:carpark/features/registered_user/domain/models/models.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/services/app_service.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisteredUserServiceRepository)
class RegisteredUserServiceRepositoryImpl
    extends RegisteredUserServiceRepository {
  final RegisteredUserServiceDataSource dataSource;

  RegisteredUserServiceRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, GenericResponseData<IDCardResponse>>>
      readIdCard() async {
    return TaskEither.tryCatch(
      () => dataSource.readIdCard(),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<List<RegisteredUserResponse>>>>
      getRegisteredUsers(ListRegisteredUserParam param) async {
    return TaskEither.tryCatch(
      () => dataSource.getRegisteredUsers(getIt<AppService>().token, param),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      getRegisteredUser(int id) async {
    return TaskEither.tryCatch(
      () => dataSource.getRegisteredUser(getIt<AppService>().token, id),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      addPhotoToRegisteredUser(int id, File photo) async {
    return TaskEither.tryCatch(
      () => dataSource.addPhotoToRegisteredUser(
          getIt<AppService>().token, id, photo),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      checkInRegisteredUser(RegisteredUserCheckInRequest request) async {
    return TaskEither.tryCatch(
      () =>
          dataSource.checkInRegisteredUser(getIt<AppService>().token, request),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      checkOutRegisteredUser(RegisteredUserCheckOutRequest request) async {
    return TaskEither.tryCatch(
      () =>
          dataSource.checkOutRegisteredUser(getIt<AppService>().token, request),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      createRegisteredUser(CreateRegisteredUserRequest request) async {
    return TaskEither.tryCatch(
      () => dataSource.createRegisteredUser(getIt<AppService>().token, request),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserLogResponse>>>
      getRegisteredUserLogs(String generatedId) async {
    return TaskEither.tryCatch(
      () => dataSource.getRegisteredUserLogs(
          getIt<AppService>().token, generatedId),
      (e, _) => Failure.fromException(e),
    ).run();
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      updateRegisteredUser(UpdateRegisteredUserRequest request) async {
    return TaskEither.tryCatch(
      () => dataSource.updateRegisteredUser(
          getIt<AppService>().token, request.id, request),
      (e, _) => Failure.fromException(e),
    ).run();
  }
}
