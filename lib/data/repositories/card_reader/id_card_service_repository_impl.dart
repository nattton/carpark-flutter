import 'package:carpark/data/repositories/card_reader/id_card_service_repository.dart';
import 'package:carpark/data/services/api/id_card_service.dart';
import 'package:carpark/domain/models/id_card_entity.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IdCardServiceRepository)
class IdCardServiceRepositoryImpl extends IdCardServiceRepository {
  new({
    required IdCardService idCardService,
    required Dio dio,
  }) : _idCardService = idCardService,
       _dio = dio;

  final IdCardService _idCardService;
  final Dio _dio;

  @override
  Future<Result<IDCardEntity>> readIdCard() async {
    try {
      final response = await _idCardService.readIdCard();
      if (response.data == null) {
        return Result.error(Failure(response.message ?? 'Failed to read card'));
      }
      return Result.ok(response.data!);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<void>> downloadPhoto(String url, String savePath) async {
    try {
      await _dio.download(url, savePath);
      return const Result.ok(null);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }
}
