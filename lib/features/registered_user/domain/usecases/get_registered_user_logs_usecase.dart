import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/entity/registered_user_logs.dart';
import 'package:carpark/features/registered_user/domain/mapper/registered_user_logs_mapper.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetRegisteredUserLogsUsecase extends UseCase<RegisteredUserLogs, int> {
  final RegisteredUserServiceRepository repository;

  GetRegisteredUserLogsUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUserLogs>> call(int params) async {
    try {
      final result = await repository.getRegisteredUserLogs(params);
      return result.fold((l) => Left(l),
          (r) => Right(RegisteredUserLogsMapper.responseMapper(r.data!)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
