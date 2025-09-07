import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/data/services/api/model/registered_user/registered_user_check_in_request.dart';
import 'package:carpark/domain/models/registered_user/registered_user.dart';
import 'package:carpark/domain/models/registered_user/registered_user_model.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserCheckInUsecase
    extends UseCase<RegisteredUser, RegisteredUserCheckInRequest> {

  RegisteredUserCheckInUsecase(this.repository);
  final RegisteredUserServiceRepository repository;

  @override
  Future<Either<Failure, RegisteredUser>> call(
    RegisteredUserCheckInRequest params,
  ) async {
    try {
      final result = await repository.checkInRegisteredUser(params);
      return result.fold(Left.new, (r) {
        return Right(RegisteredUserModel.responseMapper(r.data!));
      });
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
