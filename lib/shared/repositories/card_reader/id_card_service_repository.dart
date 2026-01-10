import 'package:carpark/shared/repositories/card_reader/entity/id_card_entity.dart';
import 'package:carpark/shared/utils/failures.dart';
import 'package:carpark/shared/utils/generic_response_data.dart';
import 'package:fpdart/fpdart.dart';

abstract class IdCardServiceRepository {
  Future<Either<Failure, GenericResponseData<IDCardEntity>>> readIdCard();
}
