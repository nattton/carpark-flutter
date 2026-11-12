import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:carpark/features/registered_user/bloc/registered_user_list/registered_user_list_bloc.dart';
import 'package:carpark/features/registered_user/models/registered_user.dart';
import 'package:carpark/features/registered_user/use_cases/registered_user_list_usecase.dart';
import 'package:carpark/shared/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/shared/services/api/model/registered_user/list_registered_user_param.dart';
import 'package:carpark/shared/utils/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

class FakeRegisteredUserListUsecase implements RegisteredUserListUsecase {
  Either<Failure, List<RegisteredUser>> resultToReturn = const Right([]);
  ListRegisteredUserParam? lastParamPassed;

  @override
  RegisteredUserServiceRepository get repository => throw UnimplementedError();

  @override
  Future<Either<Failure, List<RegisteredUser>>> call(
    ListRegisteredUserParam params,
  ) async {
    lastParamPassed = params;
    return resultToReturn;
  }
}

void main() {
  group('RegisteredUserListBloc', () {
    late FakeRegisteredUserListUsecase fakeUsecase;
    late RegisteredUserListBloc bloc;

    setUp(() {
      fakeUsecase = FakeRegisteredUserListUsecase();
      bloc = RegisteredUserListBloc(fakeUsecase);
    });

    tearDown(() async {
      await bloc.close();
    });

    test('initial state should be RegisteredUserListInitial', () {
      expect(bloc.stateValue, equals(RegisteredUserListInitial()));
    });

    group('GetRegisteredUserList', () {
      test(
        'emits loading and success states '
        'when usecase succeeds',
        () async {
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
          fakeUsecase.resultToReturn = const Right(mockUsers);

          final expectedStates = [
            RegisteredUserListInitial(),
            RegisteredUserListLoading(),
            const RegisteredUserListSuccess(mockUsers),
          ];

          final futureExpect = expectLater(
            bloc.stream,
            emitsInOrder(expectedStates),
          );

          bloc.add(GetRegisteredUserList());

          await futureExpect;

          expect(
            fakeUsecase.lastParamPassed,
            equals(const ListRegisteredUserParam(search: '')),
          );
        },
      );

      test(
        'emits loading and failure states '
        'when usecase fails',
        () async {
          const errorMessage = 'Failed to fetch registered users';
          fakeUsecase.resultToReturn = Left(Failure(errorMessage));

          final expectedStates = [
            RegisteredUserListInitial(),
            RegisteredUserListLoading(),
            const RegisteredUserListFailure(errorMessage),
          ];

          final futureExpect = expectLater(
            bloc.stream,
            emitsInOrder(expectedStates),
          );

          bloc.add(GetRegisteredUserList());

          await futureExpect;

          expect(
            fakeUsecase.lastParamPassed,
            equals(const ListRegisteredUserParam(search: '')),
          );
        },
      );
    });

    group('SearchRegisteredUser', () {
      test(
        'emits loading and success states '
        'with search query',
        () async {
          const searchText = 'สมชาย';
          const mockUsers = [
            RegisteredUser(
              id: 1,
              thaiName: 'สมชาย ใจดี',
              telephone: '0812345678',
            ),
          ];
          fakeUsecase.resultToReturn = const Right(mockUsers);

          final expectedStates = [
            RegisteredUserListInitial(),
            RegisteredUserListLoading(),
            const RegisteredUserListSuccess(mockUsers),
          ];

          final futureExpect = expectLater(
            bloc.stream,
            emitsInOrder(expectedStates),
          );

          bloc.add(const SearchRegisteredUser(searchText));

          await futureExpect;

          expect(
            fakeUsecase.lastParamPassed,
            equals(const ListRegisteredUserParam(search: searchText)),
          );
        },
      );

      test(
        'emits loading and failure states '
        'when search fails',
        () async {
          const searchText = 'Unknown';
          const errorMessage = 'Network error';
          fakeUsecase.resultToReturn = Left(Failure(errorMessage));

          final expectedStates = [
            RegisteredUserListInitial(),
            RegisteredUserListLoading(),
            const RegisteredUserListFailure(errorMessage),
          ];

          final futureExpect = expectLater(
            bloc.stream,
            emitsInOrder(expectedStates),
          );

          bloc.add(const SearchRegisteredUser(searchText));

          await futureExpect;

          expect(
            fakeUsecase.lastParamPassed,
            equals(const ListRegisteredUserParam(search: searchText)),
          );
        },
      );
    });

    group('RegisteredUserCreating', () {
      test('emits RegisteredUserListCreating state', () async {
        final futureExpect = expectLater(
          bloc.stream,
          emitsInOrder([
            RegisteredUserListInitial(),
            RegisteredUserListCreating(),
          ]),
        );

        bloc.add(RegisteredUserCreating());

        await futureExpect;
      });
    });

    group('RegisteredUserUpdating', () {
      test('emits RegisteredUserListUpdating state', () async {
        final futureExpect = expectLater(
          bloc.stream,
          emitsInOrder([
            RegisteredUserListInitial(),
            RegisteredUserListUpdating(),
          ]),
        );

        bloc.add(RegisteredUserUpdating());

        await futureExpect;
      });
    });
  });
}
