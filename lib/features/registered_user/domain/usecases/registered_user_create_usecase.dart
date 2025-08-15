import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../models/create_registered_user_request.dart';
import '../models/registered_user_response.dart';
import '../repositories/registered_user_service_repository.dart';

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
