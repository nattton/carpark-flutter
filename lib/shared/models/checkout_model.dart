import 'package:json_annotation/json_annotation.dart';

part 'checkout_model.g.dart';

@JsonSerializable()
class CheckoutModel {

  const CheckoutModel({required this.barcode, required this.gateLogId});

  factory CheckoutModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutModelFromJson(json);
  final int gateLogId;
  final String barcode;

  Map<String, dynamic> toJson() => _$CheckoutModelToJson(this);
}
