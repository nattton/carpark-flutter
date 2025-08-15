import 'package:fpdart/fpdart.dart';

import '../../../../core/data/model/generic_response_data.dart';
import '../../../../core/error/failures.dart';
import '../entity/id_card_entity.dart';

abstract class IdCardServiceRepository {
  Future<Either<Failure, GenericResponseData<IDCardEntity>>> readIdCard();
}
