import 'package:carpark/models/models.dart';
import 'package:carpark/utils/result.dart';

abstract class MemberRepository {
  Future<Result<List<MemberModel>>> getMemberList();

  Future<Result<MemberModel>> getMember(int id);

  Future<Result<MemberModel>> createMember(MemberModel member);

  Future<Result<ResponseModel>> updateMember(MemberModel member);

  Future<Result<ResponseModel>> deleteMember(int id);

  Future<Result<ResponseModel>> createVehicle(VehicleModel vehicle);

  Future<Result<ResponseModel>> updateVehicle(VehicleModel vehicle);

  Future<Result<void>> deleteVehicle(int vehicleId);
}
