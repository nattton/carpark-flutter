import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../data/models/registered_user_model.dart';
import '../entity/registered_user.dart';
import '../models/registered_user_check_out_request.dart';
import '../repositories/registered_user_service_repository.dart';

@Injectable()
class RegisteredUserCheckOutUsecase
    extends UseCase<RegisteredUser, RegisteredUserCheckOutRequest> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserCheckOutUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUser>> call(
    RegisteredUserCheckOutRequest params,
  ) async {
    try {
      final result = await repository.checkOutRegisteredUser(params);
      return result.fold(
        (l) => Left(l),
        (r) => Right(RegisteredUserModel.responseMapper(r.data!)),
      );
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
