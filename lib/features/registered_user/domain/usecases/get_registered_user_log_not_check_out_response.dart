import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../data/models/registered_user_log_model.dart';
import '../entity/registered_user_log.dart';
import '../repositories/registered_user_service_repository.dart';

@Injectable()
class GetRegisteredUserLogNotCheckOutResponseUsecase
    extends UseCase<List<RegisteredUserLog>, NoParams> {
  final RegisteredUserServiceRepository repository;

  GetRegisteredUserLogNotCheckOutResponseUsecase(this.repository);

  @override
  Future<Either<Failure, List<RegisteredUserLog>>> call(NoParams params) async {
    try {
      final result = await repository.getNotCheckOutRegisteredUser();
      return result.fold(
        (l) => Left(l),
        (r) => Right(
          RegisteredUserLogModel.responseMapperNotCheckOutList(r.data!.logs),
        ),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
