import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserGetUsecase extends UseCase<RegisteredUserResponse, int> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserGetUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUserResponse>> call(int params) async {
    final result = await repository.getRegisteredUser(params);
    return result.fold((l) => Left(l), (r) => Right(r.data!));
  }
}
