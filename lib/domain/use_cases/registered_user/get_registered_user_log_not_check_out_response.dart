import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/registered_user/registered_user_service_repository.dart';
import '../../../utils/failures.dart';
import '../../../utils/usecase.dart';
import '../../models/registered_user/registered_user_log.dart';
import '../../models/registered_user/registered_user_log_model.dart';

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
