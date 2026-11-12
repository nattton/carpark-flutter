import 'dart:io';

import 'package:carpark/data/models/registered_user/models.dart';
import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/data/services/api/registered_user_service.dart';
import 'package:carpark/domain/models/models.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisteredUserServiceRepository)
class RegisteredUserServiceRepositoryImpl
    extends RegisteredUserServiceRepository {
  new({
    required RegisteredUserService registeredUserService,
  }) : _registeredUserService = registeredUserService;

  final RegisteredUserService _registeredUserService;

  @override
  Future<Result<List<RegisteredUser>>> getRegisteredUsers(
    ListRegisteredUserParam param,
  ) async {
    try {
      final response = await _registeredUserService.getRegisteredUsers(
        param.search,
      );
      final users = (response.data ?? [])
          .map(RegisteredUserModel.responseMapper)
          .toList();
      return Result.ok(users);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<RegisteredUserModel>> getRegisteredUser(int id) async {
    try {
      final response = await _registeredUserService.getRegisteredUser(id);
      if (response.data == null) {
        return Result.error(Failure(response.message ?? 'User not found'));
      }
      return Result.ok(RegisteredUserModel.responseMapper(response.data!));
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<RegisteredUserModel>> addPhotoToRegisteredUser(
    int id,
    File photo,
  ) async {
    try {
      final response = await _registeredUserService.addPhotoToRegisteredUser(
        id,
        photo,
      );
      if (response.data == null) {
        return Result.error(Failure(response.message ?? 'Photo upload failed'));
      }
      return Result.ok(RegisteredUserModel.responseMapper(response.data!));
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<RegisteredUserModel>> checkInRegisteredUser(
    RegisteredUserCheckInRequest request,
  ) async {
    try {
      final response = await _registeredUserService.checkInRegisteredUser(
        request,
      );
      if (response.data == null) {
        return Result.error(Failure(response.message ?? 'Check in failed'));
      }
      return Result.ok(RegisteredUserModel.responseMapper(response.data!));
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<RegisteredUserModel>> checkOutRegisteredUser(
    RegisteredUserCheckOutRequest request,
  ) async {
    try {
      final response = await _registeredUserService.checkOutRegisteredUser(
        request,
      );
      if (response.data == null) {
        return Result.error(Failure(response.message ?? 'Check out failed'));
      }
      return Result.ok(RegisteredUserModel.responseMapper(response.data!));
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<RegisteredUserModel>> createRegisteredUser(
    CreateRegisteredUserRequest request,
  ) async {
    try {
      final response = await _registeredUserService.createRegisteredUser(
        request,
      );
      if (response.data == null) {
        return Result.error(Failure(response.message ?? 'Create user failed'));
      }
      return Result.ok(RegisteredUserModel.responseMapper(response.data!));
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<RegisteredUserLogs>> getRegisteredUserLogs(int id) async {
    try {
      final response = await _registeredUserService.getRegisteredUserLogs(id);
      if (response.data == null) {
        return Result.error(Failure(response.message ?? 'Logs not found'));
      }
      return Result.ok(RegisteredUserLogsModel.responseMapper(response.data!));
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<RegisteredUserModel>> updateRegisteredUser(
    UpdateRegisteredUserRequest request,
  ) async {
    try {
      final response = await _registeredUserService.updateRegisteredUser(
        request.id,
        request,
      );
      if (response.data == null) {
        return Result.error(Failure(response.message ?? 'Update user failed'));
      }
      return Result.ok(RegisteredUserModel.responseMapper(response.data!));
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<List<RegisteredUserLog>>> getNotCheckOutRegisteredUser() async {
    try {
      final response = await _registeredUserService
          .getNotCheckOutRegisteredUser();
      final logs = RegisteredUserLogModel.responseMapperNotCheckOutList(
        response.data?.logs ?? [],
      );
      return Result.ok(logs);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }
}
