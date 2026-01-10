import 'package:carpark/features/registered_user/models/registered_user.dart';
import 'package:carpark/features/registered_user/models/registered_user_model.dart';
import 'package:carpark/shared/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/shared/services/api/model/registered_user/list_registered_user_param.dart';
import 'package:carpark/shared/utils/failures.dart';
import 'package:carpark/shared/utils/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserListUsecase
    extends UseCase<List<RegisteredUser>, ListRegisteredUserParam> {
  RegisteredUserListUsecase(this.repository);
  final RegisteredUserServiceRepository repository;

  @override
  Future<Either<Failure, List<RegisteredUser>>> call(
    ListRegisteredUserParam params,
  ) async {
    final result = await repository.getRegisteredUsers(params);
    return result.fold(
      Left.new,
      (r) => Right(
        (r.data ?? []).map(RegisteredUserModel.responseMapper).toList(),
      ),
    );
  }
}
