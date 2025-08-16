import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../domain/models/member/member_model.dart';
import '../../../../../../domain/models/member/vehicle_model.dart';

part 'get_member_response.freezed.dart';
part 'get_member_response.g.dart';

@freezed
abstract class GetMemberResponse with _$GetMemberResponse {
  const GetMemberResponse._();

  const factory GetMemberResponse({
    int? id,
    String? name,
    String? telephone,
    String? type,
    String? status,
    List<VehicleResponse>? vehicles,
  }) = _GetMemberResponse;

  factory GetMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMemberResponseFromJson(json);

  MemberModel toDomain() => MemberModel(
    id: id,
    name: name,
    telephone: telephone,
    type: type,
    status: status,
    vehicles: vehicles
        ?.map(
          (e) => VehicleModel(
            id: e.id,
            plateNumber: e.plateNumber,
            plateProvince: e.plateProvince,
            brand: e.brand,
            color: e.color,
            telephone: e.telephone,
            resemble: e.resemble,
          ),
        )
        .toList(),
  );
}

@freezed
abstract class VehicleResponse with _$VehicleResponse {
  const factory VehicleResponse({
    int? id,
    int? memberId,
    String? plateNumber,
    String? plateProvince,
    String? brand,
    String? color,
    String? telephone,
    String? resemble,
  }) = _VehicleResponse;

  factory VehicleResponse.fromJson(Map<String, dynamic> json) =>
      _$VehicleResponseFromJson(json);
}
