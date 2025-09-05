import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../models/models.dart';
import '../../../utils/result.dart';
import '../../services/api/api_service.dart';
import '../../services/api/model/member/member.dart';
import '../../services/api/model/vehicle/create_vehicle_request/create_vehicle_request.dart';
import '../../services/api/model/vehicle/update_vehicle_request/update_vehicle_request.dart';
import 'member_repository.dart';

@prod
@Injectable(as: MemberRepository)
class MemberRepositoryRemote extends MemberRepository {
  MemberRepositoryRemote({required ApiService apiService})
    : _apiService = apiService;

  final ApiService _apiService;

  @override
  Future<Result<List<MemberModel>>> getMemberList() async {
    try {
      final response = await _apiService.getMemberList();
      return Result.ok(response.map((e) => e.toDomain()).toList());
    } on DioException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<MemberModel>> createMember(MemberModel member) async {
    try {
      final response = await _apiService.createMember(
        CreateMemberRequest(
          name: member.name,
          telephone: member.telephone,
          type: member.type,
          status: member.status,
        ),
      );
      return Result.ok(response.toDomain());
    } on DioException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<MemberModel>> getMember(int id) async {
    try {
      final response = await _apiService.getMember(id);
      return Result.ok(response.toDomain());
    } on DioException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<ResponseModel>> updateMember(MemberModel member) async {
    try {
      final response = await _apiService.updateMember(
        member.id,
        UpdateMemberRequest(
          name: member.name,
          telephone: member.telephone,
          type: member.type,
          status: member.status,
        ),
      );
      return Result.ok(response);
    } on DioException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<ResponseModel>> deleteMember(int id) async {
    try {
      final response = await _apiService.deleteMember(id);
      return Result.ok(response);
    } on DioException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<ResponseModel>> createVehicle(VehicleModel vehicle) async {
    try {
      final response = await _apiService.createVehicle(
        vehicle.memberId!,
        CreateVehicleRequest(
          memberId: vehicle.memberId,
          plateNumber: vehicle.plateNumber,
          plateProvince: vehicle.plateProvince,
          brand: vehicle.brand,
          color: vehicle.color,
          telephone: vehicle.telephone,
          resemble: vehicle.resemble,
        ),
      );
      return Result.ok(response);
    } on DioException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<ResponseModel>> updateVehicle(VehicleModel vehicle) async {
    try {
      final response = await _apiService.updateVehicle(
        vehicle.memberId!,
        UpdateVehicleRequest(
          id: vehicle.id,
          memberId: vehicle.memberId,
          plateNumber: vehicle.plateNumber,
          plateProvince: vehicle.plateProvince,
          brand: vehicle.brand,
          color: vehicle.color,
          telephone: vehicle.telephone,
          resemble: vehicle.resemble,
        ),
      );
      return Result.ok(response);
    } on DioException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> deleteVehicle(int vehicleId) async {
    try {
      await _apiService.deleteVehicle(vehicleId);
      return Result.ok(null);
    } on DioException catch (e) {
      return Result.error(e);
    }
  }
}
