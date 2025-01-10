import 'package:carpark/core/data/model/generic_response_data.dart';
import 'package:carpark/features/entrance/domain/entity/id_card_entity.dart';

abstract class IdCardServiceDataSource {
  Future<GenericResponseData<IDCardEntity>> readIdCard();
}
