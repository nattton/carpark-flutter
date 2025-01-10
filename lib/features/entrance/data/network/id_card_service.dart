import 'package:carpark/constants.dart';
import 'package:carpark/core/data/model/generic_response_data.dart';
import 'package:carpark/features/entrance/domain/entity/id_card_entity.dart';
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

  @GET("/smartcardreader")
  Future<GenericResponseData<IDCardEntity>> readIdCard();
}
