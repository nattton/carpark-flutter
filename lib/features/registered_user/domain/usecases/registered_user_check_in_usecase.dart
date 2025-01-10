import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/domain/mapper/registered_user_mapper.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_check_in_request.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserCheckInUsecase
    extends UseCase<RegisteredUser, RegisteredUserCheckInRequest> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserCheckInUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUser>> call(
      RegisteredUserCheckInRequest params) async {
    try {
      final result = await repository.checkInRegisteredUser(params);
      return result.fold((l) => Left(l), (r) {
        return Right(RegisteredUserMapper.responseMapper(r.data!));
      });
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
