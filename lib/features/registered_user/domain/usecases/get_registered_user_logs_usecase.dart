import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../data/models/registered_user_logs_model.dart';
import '../entity/registered_user_logs.dart';
import '../repositories/registered_user_service_repository.dart';

@Injectable()
class GetRegisteredUserLogsUsecase extends UseCase<RegisteredUserLogs, int> {
  final RegisteredUserServiceRepository repository;

  GetRegisteredUserLogsUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUserLogs>> call(int params) async {
    try {
      final result = await repository.getRegisteredUserLogs(params);
      return result.fold(
        (l) => Left(l),
        (r) => Right(RegisteredUserLogsModel.responseMapper(r.data!)),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
