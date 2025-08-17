import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../data/models/registered_user_model.dart';
import '../entity/registered_user.dart';
import '../models/update_registered_user_request.dart';
import '../repositories/registered_user_service_repository.dart';

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
