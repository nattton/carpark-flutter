import 'package:carpark/data/repositories/member/member_repository.dart';
import 'package:carpark/models/models.dart';
import 'package:carpark/utils/result.dart';
import 'package:injectable/injectable.dart';

@dev
@Injectable(as: MemberRepository)
class MemberRepositoryLocal extends MemberRepository {
  MemberRepositoryLocal();

  @override
  Future<Result<List<MemberModel>>> getMemberList() async {
    final members = [
      const MemberModel(
        id: 1,
        name: 'ABC',
        telephone: '0895470000',
        type: 'visitor',
        status: 'active',
        vehicles: [],
      ),
      const MemberModel(
        id: 2,
        name: 'DEF',
        telephone: '0895470000',
        type: 'visitor',
        status: 'active',
        vehicles: [],
      ),
    ];
    return Result.ok(members);
  }

  @override
  Future<Result<MemberModel>> createMember(MemberModel member) async {
    const member = MemberModel(
      id: 1,
      name: 'HIJ',
      telephone: '0895470000',
      type: 'visitor',
      status: 'active',
      vehicles: [],
    );
    return const Result.ok(member);
  }

  @override
  Future<Result<MemberModel>> getMember(int id) async {
    const member = MemberModel(
      id: 1,
      name: 'KLM',
      telephone: '0895470000',
      type: 'visitor',
      status: 'active',
      vehicles: [],
    );
    return const Result.ok(member);
  }

  @override
  Future<Result<ResponseModel>> updateMember(MemberModel member) async {
    const response = ResponseModel(message: 'Update Successfully');
    return const Result.ok(response);
  }

  @override
  Future<Result<ResponseModel>> deleteMember(int id) async {
    const response = ResponseModel(message: 'Delete Successfully');
    return const Result.ok(response);
  }

  @override
  Future<Result<ResponseModel>> createVehicle(VehicleModel vehicle) async {
    const response = ResponseModel(message: 'Create vehicle Successfully');
    return const Result.ok(response);
  }

  @override
  Future<Result<ResponseModel>> updateVehicle(VehicleModel vehicle) async {
    const response = ResponseModel(message: 'Update vehicle Successfully');
    return const Result.ok(response);
  }

  @override
  Future<Result<void>> deleteVehicle(int vehicleId) async {
    return const Result.ok(null);
  }
}
