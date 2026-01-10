import 'package:carpark/shared/repositories/card_reader/entity/id_card_entity.dart';
import 'package:carpark/shared/repositories/card_reader/id_card_service_repository.dart';
import 'package:carpark/shared/utils/failures.dart';
import 'package:carpark/shared/utils/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ReadIdCardUsecase extends UseCase<IDCardEntity, NoParams> {
  ReadIdCardUsecase(this.repository);
  final IdCardServiceRepository repository;

  @override
  Future<Either<Failure, IDCardEntity>> call(NoParams params) async {
    final result = await repository.readIdCard();
    return result.fold(Left.new, (r) => Right(r.data!));
  }
}
