import 'dart:io';

import 'package:carpark/data/models/registered_user/models.dart';
import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/domain/models/models.dart';
import 'package:carpark/ui/features/registered_user/view_models/registered_user_list_viewmodel.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeRegisteredUserRepository implements RegisteredUserServiceRepository {
  Result<List<RegisteredUser>> resultToReturn = const Result.ok([]);
  ListRegisteredUserParam? lastParamPassed;

  @override
  Future<Result<List<RegisteredUser>>> getRegisteredUsers(
    ListRegisteredUserParam param,
  ) async {
    lastParamPassed = param;
    return resultToReturn;
  }

  @override
  Future<Result<RegisteredUserModel>> addPhotoToRegisteredUser(
    int id,
    File photo,
  ) => throw UnimplementedError();

  @override
  Future<Result<RegisteredUserModel>> checkInRegisteredUser(
    RegisteredUserCheckInRequest request,
  ) => throw UnimplementedError();

  @override
  Future<Result<RegisteredUserModel>> checkOutRegisteredUser(
    RegisteredUserCheckOutRequest request,
  ) => throw UnimplementedError();

  @override
  Future<Result<RegisteredUserModel>> createRegisteredUser(
    CreateRegisteredUserRequest request,
  ) => throw UnimplementedError();

  @override
  Future<Result<List<RegisteredUserLog>>> getNotCheckOutRegisteredUser() =>
      throw UnimplementedError();

  @override
  Future<Result<RegisteredUserModel>> getRegisteredUser(int id) =>
      throw UnimplementedError();

  @override
  Future<Result<RegisteredUserLogs>> getRegisteredUserLogs(int id) =>
      throw UnimplementedError();

  @override
  Future<Result<RegisteredUserModel>> updateRegisteredUser(
    UpdateRegisteredUserRequest request,
  ) => throw UnimplementedError();
}

void main() {
  group('RegisteredUserListViewModel', () {
    late FakeRegisteredUserRepository fakeRepository;
    late RegisteredUserListViewModel viewModel;

    setUp(() {
      fakeRepository = FakeRegisteredUserRepository();
      viewModel = RegisteredUserListViewModel(repository: fakeRepository);
    });

    tearDown(() {
      viewModel.dispose();
    });

    test('initial state should be list mode and empty', () {
      expect(viewModel.mode, equals(RegisteredUserListMode.list));
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.registeredUsers, isEmpty);
      expect(viewModel.errorMessage, isNull);
    });

    group('getRegisteredUserList', () {
      test('updates registeredUsers when repository succeeds', () async {
        const mockUsers = [
          RegisteredUser(
            id: 1,
            thaiName: 'สมชาย ใจดี',
            telephone: '0812345678',
          ),
          RegisteredUser(
            id: 2,
            thaiName: 'สมหญิง รักดี',
            telephone: '0898765432',
          ),
        ];
        fakeRepository.resultToReturn = const Result.ok(mockUsers);

        await viewModel.getRegisteredUserList();

        expect(viewModel.isLoading, isFalse);
        expect(viewModel.registeredUsers, equals(mockUsers));
        expect(viewModel.errorMessage, isNull);
        expect(
          fakeRepository.lastParamPassed,
          equals(const ListRegisteredUserParam(search: '')),
        );
      });

      test('sets errorMessage when repository fails', () async {
        const errorMessage = 'Failed to fetch registered users';
        fakeRepository.resultToReturn = Result.error(Failure(errorMessage));

        await viewModel.getRegisteredUserList();

        expect(viewModel.isLoading, isFalse);
        expect(viewModel.errorMessage, equals(errorMessage));
        expect(
          fakeRepository.lastParamPassed,
          equals(const ListRegisteredUserParam(search: '')),
        );
      });
    });

    group('searchRegisteredUser', () {
      test('updates registeredUsers with search query', () async {
        const searchText = 'สมชาย';
        const mockUsers = [
          RegisteredUser(
            id: 1,
            thaiName: 'สมชาย ใจดี',
            telephone: '0812345678',
          ),
        ];
        fakeRepository.resultToReturn = const Result.ok(mockUsers);

        await viewModel.searchRegisteredUser(searchText);

        expect(viewModel.isLoading, isFalse);
        expect(viewModel.registeredUsers, equals(mockUsers));
        expect(
          fakeRepository.lastParamPassed,
          equals(const ListRegisteredUserParam(search: searchText)),
        );
      });

      test('sets errorMessage when search fails', () async {
        const searchText = 'Unknown';
        const errorMessage = 'Network error';
        fakeRepository.resultToReturn = Result.error(Failure(errorMessage));

        await viewModel.searchRegisteredUser(searchText);

        expect(viewModel.isLoading, isFalse);
        expect(viewModel.errorMessage, equals(errorMessage));
        expect(
          fakeRepository.lastParamPassed,
          equals(const ListRegisteredUserParam(search: searchText)),
        );
      });
    });

    group('mode transitions', () {
      test('startCreating sets mode to creating', () {
        viewModel.startCreating();
        expect(viewModel.mode, equals(RegisteredUserListMode.creating));
      });

      test('startUpdating sets mode to updating', () {
        viewModel.startUpdating();
        expect(viewModel.mode, equals(RegisteredUserListMode.updating));
      });
    });
  });
}
