import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/registered_user/registered_user_service_repository.dart';
import '../../../data/services/api/model/registered_user/create_registered_user_request.dart';
import '../../../data/services/api/model/registered_user/registered_user_response.dart';
import '../../../utils/failures.dart';
import '../../../utils/usecase.dart';

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
