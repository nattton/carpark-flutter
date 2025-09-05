import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/registered_user/registered_user_service_repository.dart';
import '../../../data/services/api/model/registered_user/list_registered_user_param.dart';
import '../../../utils/failures.dart';
import '../../../utils/usecase.dart';
import '../../models/registered_user/registered_user.dart';
import '../../models/registered_user/registered_user_model.dart';

@Injectable()
class RegisteredUserListUsecase
    extends UseCase<List<RegisteredUser>, ListRegisteredUserParam> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserListUsecase(this.repository);

  @override
  Future<Either<Failure, List<RegisteredUser>>> call(
    ListRegisteredUserParam params,
  ) async {
    final result = await repository.getRegisteredUsers(params);
    return result.fold(
      (l) => Left(l),
      (r) => Right(
        (r.data ?? [])
            .map((e) => RegisteredUserModel.responseMapper(e))
            .toList(),
      ),
    );
  }
}
