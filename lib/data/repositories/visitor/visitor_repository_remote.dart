import 'dart:io';

import 'package:carpark/data/repositories/visitor/visitor_repository.dart';
import 'package:carpark/data/services/api/api_service.dart';
import 'package:carpark/domain/models/checkout_model.dart';
import 'package:carpark/domain/models/visitor_model.dart';
import 'package:carpark/utils/failures.dart';
import 'package:carpark/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VisitorRepository)
class VisitorRepositoryRemote extends VisitorRepository {
  new({required ApiService apiService})
    : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<Result<VisitorModel>> createVisitor(VisitorModel visitor) async {
    try {
      final created = await _apiService.createVisitor(visitor);
      return Result.ok(created);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<List<VisitorModel>>> listVisitor(
    String date,
    String dateTo,
  ) async {
    try {
      final list = await _apiService.listVisitor(date, dateTo);
      return Result.ok(list);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<VisitorModel>> getVisitor(int id) async {
    try {
      final visitor = await _apiService.getVisitor(id);
      return Result.ok(visitor);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<VisitorModel>> addPhotoVisitor(int id, File photo) async {
    try {
      final visitor = await _apiService.addPhotoVisitor(id, photo);
      return Result.ok(visitor);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<VisitorModel>> addImageToVisitor(
    int id,
    String type,
    File file,
  ) async {
    try {
      final visitor = await _apiService.addImageToVisitor(id, type, file);
      return Result.ok(visitor);
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }

  @override
  Future<Result<VisitorModel>> checkoutVisitor(CheckoutModel checkout) async {
    try {
      final visitor = await _apiService.checkoutVisitor(checkout);
      return Result.ok(visitor);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == HttpStatus.badRequest) {
        return Result.error(
          Failure('ข้อมูลไม่ถูกต้อง หรือ ไม่ได้เปลี่ยนคีย์บอร์ดเป็นภาษาอังกฤษ'),
        );
      } else if (statusCode == HttpStatus.notFound) {
        return Result.error(Failure('ไม่พบข้อมูล'));
      }
      return Result.error(Failure.fromException(e));
    } on Object catch (e) {
      return Result.error(Failure.fromException(e));
    }
  }
}
