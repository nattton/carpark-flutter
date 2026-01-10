import 'package:carpark/features/registered_user/models/registered_user.dart';
import 'package:carpark/features/registered_user/models/registered_user_model.dart';
import 'package:carpark/shared/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/shared/services/api/model/registered_user/registered_user_check_out_request.dart';
import 'package:carpark/shared/utils/failures.dart';
import 'package:carpark/shared/utils/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserCheckOutUsecase
    extends UseCase<RegisteredUser, RegisteredUserCheckOutRequest> {
  RegisteredUserCheckOutUsecase(this.repository);
  final RegisteredUserServiceRepository repository;

  @override
  Future<Either<Failure, RegisteredUser>> call(
    RegisteredUserCheckOutRequest params,
  ) async {
    try {
      final result = await repository.checkOutRegisteredUser(params);
      return result.fold(
        Left.new,
        (r) => Right(RegisteredUserModel.responseMapper(r.data!)),
      );
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
