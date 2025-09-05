import 'package:fpdart/fpdart.dart';

import '../../../../utils/failures.dart';
import '../../../../utils/generic_response_data.dart';
import '../entity/id_card_entity.dart';

abstract class IdCardServiceRepository {
  Future<Either<Failure, GenericResponseData<IDCardEntity>>> readIdCard();
}
