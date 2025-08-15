import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../data/models/registered_user_model.dart';
import '../entity/registered_user.dart';
import '../models/list_registered_user_param.dart';
import '../repositories/registered_user_service_repository.dart';

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
