import 'dart:io';

import 'package:carpark/core/data/model/generic_response_data.dart';
import 'package:carpark/core/error/failures.dart';
import 'package:carpark/features/registered_user/data/datasources/registered_user_service_datasource.dart';
import 'package:carpark/features/registered_user/domain/models/models.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/services/app_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class RegisteredUserServiceRepositoryImpl
    extends RegisteredUserServiceRepository {
  final RegisteredUserServiceDataSource dataSource;

  RegisteredUserServiceRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, GenericResponseData<IDCardResponse>>>
      readIdCard() async {
    try {
      final result = await dataSource.readIdCard();
      return Right(result);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ?? e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GenericResponseData<List<RegisteredUserResponse>>>>
      getRegisteredUsers(ListRegisteredUserParam param) async {
    try {
      final result =
          await dataSource.getRegisteredUsers(sl<AppService>().token, param);
      return Right(result);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ?? e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      addPhotoToRegisteredUser(int id, File photo) async {
    try {
      final result = await dataSource.addPhotoToRegisteredUser(
          sl<AppService>().token, id, photo);
      return Right(result);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ?? e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      checkInRegisteredUser(RegisteredUserCheckInRequest request) async {
    try {
      final result = await dataSource.checkInRegisteredUser(
          sl<AppService>().token, request);
      return Right(result);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ?? e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      checkOutRegisteredUser(RegisteredUserCheckOutRequest request) async {
    try {
      final result = await dataSource.checkOutRegisteredUser(
          sl<AppService>().token, request);
      return Right(result);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ?? e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      createRegisteredUser(CreateRegisteredUserRequest request) async {
    try {
      final result = await dataSource.createRegisteredUser(
          sl<AppService>().token, request);
      return Right(result);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ?? e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserLogResponse>>>
      getRegisteredUserLogs(String generatedId) async {
    try {
      final result = await dataSource.getRegisteredUserLogs(
          sl<AppService>().token, generatedId);
      return Right(result);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ?? e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GenericResponseData<RegisteredUserResponse>>>
      updateRegisteredUser(RegisteredUserUpdateRequest request) async {
    try {
      final result = await dataSource.updateRegisteredUser(
          sl<AppService>().token, request.id, request);
      return Right(result);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ?? e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
