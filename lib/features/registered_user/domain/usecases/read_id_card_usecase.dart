import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../../gateway/domain/entity/id_card_entity.dart';
import '../../../gateway/domain/repository/id_card_service_repository.dart';

@Injectable()
class ReadIdCardUsecase extends UseCase<IDCardEntity, NoParams> {
  final IdCardServiceRepository repository;

  ReadIdCardUsecase(this.repository);

  @override
  Future<Either<Failure, IDCardEntity>> call(NoParams params) async {
    final result = await repository.readIdCard();
    return result.fold((l) => Left(l), (r) => Right(r.data!));
  }
}
