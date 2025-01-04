import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_check_out_request.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:dartz/dartz.dart';

class RegisteredUserCheckOutUsecase
    extends UseCase<RegisteredUserResponse, RegisteredUserCheckOutRequest> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserCheckOutUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUserResponse>> call(
      RegisteredUserCheckOutRequest params) async {
    final result = await repository.checkOutRegisteredUser(params);
    return result.fold((l) => Left(l), (r) => Right(r.data!));
  }
}
