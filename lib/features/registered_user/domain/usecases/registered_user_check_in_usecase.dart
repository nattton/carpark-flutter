import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../data/models/registered_user_model.dart';
import '../entity/registered_user.dart';
import '../models/registered_user_check_in_request.dart';
import '../repositories/registered_user_service_repository.dart';

@Injectable()
class RegisteredUserCheckInUsecase
    extends UseCase<RegisteredUser, RegisteredUserCheckInRequest> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserCheckInUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUser>> call(
    RegisteredUserCheckInRequest params,
  ) async {
    try {
      final result = await repository.checkInRegisteredUser(params);
      return result.fold((l) => Left(l), (r) {
        return Right(RegisteredUserModel.responseMapper(r.data!));
      });
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
