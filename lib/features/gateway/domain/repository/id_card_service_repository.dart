import 'package:carpark/core/data/model/generic_response_data.dart';
import 'package:carpark/core/error/failures.dart';
import 'package:carpark/features/gateway/domain/entity/id_card_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class IdCardServiceRepository {
  Future<Either<Failure, GenericResponseData<IDCardEntity>>> readIdCard();
}
