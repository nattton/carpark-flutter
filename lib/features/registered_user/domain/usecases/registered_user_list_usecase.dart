import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/domain/mapper/registered_user_list_mapper.dart';
import 'package:carpark/features/registered_user/domain/models/list_registered_user_param.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserListUsecase
    extends UseCase<List<RegisteredUser>, ListRegisteredUserParam> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserListUsecase(this.repository);

  @override
  Future<Either<Failure, List<RegisteredUser>>> call(
      ListRegisteredUserParam params) async {
    final result = await repository.getRegisteredUsers(params);
    return result.fold((l) => Left(l),
        (r) => Right(RegisteredUserListMapper.responseMapper(r.data ?? [])));
  }
}
