import 'package:carpark/features/registered_user/models/registered_user.dart';
import 'package:carpark/features/registered_user/models/registered_user_model.dart';
import 'package:carpark/shared/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/shared/services/api/model/registered_user/update_registered_user_request.dart';
import 'package:carpark/shared/utils/failures.dart';
import 'package:carpark/shared/utils/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserUpdateUsecase
    extends UseCase<RegisteredUser, UpdateRegisteredUserRequest> {
  RegisteredUserUpdateUsecase(this.repository);
  final RegisteredUserServiceRepository repository;

  @override
  Future<Either<Failure, RegisteredUser>> call(
    UpdateRegisteredUserRequest params,
  ) async {
    try {
      final result = await repository.updateRegisteredUser(params);
      return result.fold(Left.new, (r) {
        return Right(RegisteredUserModel.responseMapper(r.data!));
      });
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
