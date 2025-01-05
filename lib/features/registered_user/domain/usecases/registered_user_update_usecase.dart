import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_update_request.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:dartz/dartz.dart';

class RegisteredUserUpdateUsecase
    extends UseCase<RegisteredUserResponse, RegisteredUserUpdateRequest> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserUpdateUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUserResponse>> call(
      RegisteredUserUpdateRequest params) async {
    final result = await repository.updateRegisteredUser(params);
    return result.fold((l) => Left(l), (r) => Right(r.data!));
  }
}
