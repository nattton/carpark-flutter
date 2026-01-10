import 'package:carpark/shared/repositories/card_reader/entity/id_card_entity.dart';
import 'package:carpark/shared/utils/generic_response_data.dart';

abstract class IdCardServiceDataSource {
  Future<GenericResponseData<IDCardEntity>> readIdCard();
}
