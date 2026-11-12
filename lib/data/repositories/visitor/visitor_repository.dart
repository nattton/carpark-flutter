import 'dart:io';

import 'package:carpark/domain/models/checkout_model.dart';
import 'package:carpark/domain/models/visitor_model.dart';
import 'package:carpark/utils/result.dart';

abstract class VisitorRepository {
  Future<Result<VisitorModel>> createVisitor(VisitorModel visitor);
  Future<Result<List<VisitorModel>>> listVisitor(String date, String dateTo);
  Future<Result<VisitorModel>> getVisitor(int id);
  Future<Result<VisitorModel>> addPhotoVisitor(int id, File photo);
  Future<Result<VisitorModel>> addImageToVisitor(
    int id,
    String type,
    File file,
  );
  Future<Result<VisitorModel>> checkoutVisitor(CheckoutModel checkout);
}
