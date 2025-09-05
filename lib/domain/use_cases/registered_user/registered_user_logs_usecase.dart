import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/registered_user/registered_user_service_repository.dart';
import '../../../data/services/api/model/registered_user/registered_user_logs_response.dart';
import '../../../utils/failures.dart';
import '../../../utils/usecase.dart';

@Injectable()
class RegisteredUserLogsUsecase
    extends UseCase<RegisteredUserLogsResponse, int> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserLogsUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUserLogsResponse>> call(int params) async {
    final result = await repository.getRegisteredUserLogs(params);
    return result.fold((l) => Left(l), (r) => Right(r.data!));
  }
}
