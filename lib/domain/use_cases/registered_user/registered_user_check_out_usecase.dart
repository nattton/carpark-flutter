import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/registered_user/registered_user_service_repository.dart';
import '../../../data/services/api/model/registered_user/registered_user_check_out_request.dart';
import '../../../utils/failures.dart';
import '../../../utils/usecase.dart';
import '../../models/registered_user/registered_user.dart';
import '../../models/registered_user/registered_user_model.dart';

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
