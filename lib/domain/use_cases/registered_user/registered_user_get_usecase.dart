import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/registered_user/registered_user_service_repository.dart';
import '../../../data/services/api/model/registered_user/registered_user_response.dart';
import '../../../utils/failures.dart';
import '../../../utils/usecase.dart';

@Injectable()
class RegisteredUserGetUsecase extends UseCase<RegisteredUserResponse, int> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserGetUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUserResponse>> call(int params) async {
    final result = await repository.getRegisteredUser(params);
    return result.fold((l) => Left(l), (r) => Right(r.data!));
  }
}
