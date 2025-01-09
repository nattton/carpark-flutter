import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/domain/mapper/registered_user_mapper.dart';
import 'package:carpark/features/registered_user/domain/models/update_registered_user_request.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserUpdateUsecase
    extends UseCase<RegisteredUser, UpdateRegisteredUserRequest> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserUpdateUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUser>> call(
      UpdateRegisteredUserRequest params) async {
    try {
      final result = await repository.updateRegisteredUser(params);
      return result.fold((l) => Left(l), (r) {
        return Right(RegisteredUserMapper.responseMapper(r.data!));
      });
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
