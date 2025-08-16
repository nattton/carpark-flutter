import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_vehicle_request.freezed.dart';
part 'create_vehicle_request.g.dart';

@freezed
abstract class CreateVehicleRequest with _$CreateVehicleRequest {
  const factory CreateVehicleRequest({
    int? memberId,
    String? plateNumber,
    String? plateProvince,
    String? brand,
    String? color,
    String? telephone,
    String? resemble,
  }) = _CreateVehicleRequest;

  factory CreateVehicleRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateVehicleRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$CreateVehicleRequestToJson(this as _CreateVehicleRequest);
}
