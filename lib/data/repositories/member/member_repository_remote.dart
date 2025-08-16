import 'package:dio/dio.dart';

import '../../../models/models.dart';
import '../../../utils/result.dart';
import '../../services/api/api_service.dart';
import 'member_repository.dart';

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
  Future<Result<MemberModel>> createMember(MemberModel member) {
    // TODO: implement createMember
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> deleteMember(int id) {
    // TODO: implement deleteMember
    throw UnimplementedError();
  }

  @override
  Future<Result<MemberModel>> getMember(int id) {
    // TODO: implement getMember
    throw UnimplementedError();
  }

  @override
  Future<Result<MemberModel>> updateMember(MemberModel member) {
    // TODO: implement updateMember
    throw UnimplementedError();
  }
}
