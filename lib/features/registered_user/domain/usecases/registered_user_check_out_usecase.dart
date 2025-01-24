import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/data/models/registered_user_model.dart';
import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_check_out_request.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserCheckOutUsecase
    extends UseCase<RegisteredUser, RegisteredUserCheckOutRequest> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserCheckOutUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUser>> call(
      RegisteredUserCheckOutRequest params) async {
    try {
      final result = await repository.checkOutRegisteredUser(params);
      return result.fold((l) => Left(l),
          (r) => Right(RegisteredUserModel.responseMapper(r.data!)));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
