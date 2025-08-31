import 'package:injectable/injectable.dart';

import '../../../models/models.dart';
import '../../../utils/result.dart';
import 'member_repository.dart';

@dev
@Injectable(as: MemberRepository)
class MemberRepositoryLocal extends MemberRepository {
  MemberRepositoryLocal();

  @override
  Future<Result<List<MemberModel>>> getMemberList() async {
    final members = [
      MemberModel(
        id: 1,
        name: "ABC",
        telephone: "0895470000",
        type: "visitor",
        status: "active",
        vehicles: [],
      ),
      MemberModel(
        id: 2,
        name: "DEF",
        telephone: "0895470000",
        type: "visitor",
        status: "active",
        vehicles: [],
      ),
    ];
    return Result.ok(members);
  }

  @override
  Future<Result<MemberModel>> createMember(MemberModel member) async {
    final member = MemberModel(
      id: 1,
      name: "HIJ",
      telephone: "0895470000",
      type: "visitor",
      status: "active",
      vehicles: [],
    );
    return Result.ok(member);
  }

  @override
  Future<Result<MemberModel>> getMember(int id) async {
    final member = MemberModel(
      id: 1,
      name: "KLM",
      telephone: "0895470000",
      type: "visitor",
      status: "active",
      vehicles: [],
    );
    return Result.ok(member);
  }

  @override
  Future<Result<ResponseModel>> updateMember(MemberModel member) async {
    final response = ResponseModel(message: 'Update Successfully');
    return Result.ok(response);
  }

  @override
  Future<Result<ResponseModel>> deleteMember(int id) async {
    final response = ResponseModel(message: 'Delete Successfully');
    return Result.ok(response);
  }
}
