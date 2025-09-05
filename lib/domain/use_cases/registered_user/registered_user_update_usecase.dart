import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/registered_user/registered_user_service_repository.dart';
import '../../../data/services/api/model/registered_user/update_registered_user_request.dart';
import '../../../utils/failures.dart';
import '../../../utils/usecase.dart';
import '../../models/registered_user/registered_user.dart';
import '../../models/registered_user/registered_user_model.dart';

@Injectable()
class RegisteredUserUpdateUsecase
    extends UseCase<RegisteredUser, UpdateRegisteredUserRequest> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserUpdateUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUser>> call(
    UpdateRegisteredUserRequest params,
  ) async {
    try {
      final result = await repository.updateRegisteredUser(params);
      return result.fold((l) => Left(l), (r) {
        return Right(RegisteredUserModel.responseMapper(r.data!));
      });
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
