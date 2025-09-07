import 'package:carpark/config/constants.dart';
import 'package:carpark/features/gateway/domain/entity/id_card_entity.dart';
import 'package:carpark/utils/generic_response_data.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'id_card_service.g.dart';

@module
abstract class IdCardServiceModule {
  @singleton
  IdCardService create(Dio dio) => IdCardService(dio);
}

@RestApi(baseUrl: kSmartCardReaderUrl)
abstract class IdCardService {
  factory IdCardService(Dio dio) = _IdCardService;

  @GET('/smartcardreader')
  Future<GenericResponseData<IDCardEntity>> readIdCard();
}
