import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/models/create_registered_user_request.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserCreateUsecase
    extends UseCase<RegisteredUserResponse, CreateRegisteredUserRequest> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserCreateUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUserResponse>> call(
    CreateRegisteredUserRequest params,
  ) async {
    final result = await repository.createRegisteredUser(params);
    return result.fold((l) => Left(l), (r) => Right(r.data!));
  }
}
