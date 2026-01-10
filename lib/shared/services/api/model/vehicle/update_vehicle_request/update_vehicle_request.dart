import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_vehicle_request.freezed.dart';
part 'update_vehicle_request.g.dart';

@freezed
abstract class UpdateVehicleRequest with _$UpdateVehicleRequest {
  const factory UpdateVehicleRequest({
    int? id,
    int? memberId,
    String? plateNumber,
    String? plateProvince,
    String? brand,
    String? color,
    String? telephone,
    String? resemble,
  }) = _UpdateVehicleRequest;

  factory UpdateVehicleRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateVehicleRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$UpdateVehicleRequestToJson(this as _UpdateVehicleRequest);
}
