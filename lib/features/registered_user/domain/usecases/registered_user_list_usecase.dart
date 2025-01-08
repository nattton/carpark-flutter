import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/models/list_registered_user_param.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserListUsecase
    extends UseCase<List<RegisteredUserResponse>, ListRegisteredUserParam> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserListUsecase(this.repository);

  @override
  Future<Either<Failure, List<RegisteredUserResponse>>> call(
      ListRegisteredUserParam params) async {
    final result = await repository.getRegisteredUsers(params);
    return result.fold((l) => Left(l), (r) => Right(r.data ?? []));
  }
}
