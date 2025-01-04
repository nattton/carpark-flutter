import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/models/list_registered_user_param.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:dartz/dartz.dart';

class RegisteredUserListUsecase
    extends UseCase<List<RegisteredUserResponse>, ListRegisteredUserParam> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserListUsecase(this.repository);

  @override
  Future<Either<Failure, List<RegisteredUserResponse>>> call(
      ListRegisteredUserParam param) async {
    final result = await repository.getRegisteredUsers(param);
    return result.fold((l) => Left(l), (r) => Right(r.data ?? []));
  }
}
