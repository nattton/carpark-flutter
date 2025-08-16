import 'package:flutter/foundation.dart';

import '../../../models/models.dart';
import '../../../utils/result.dart';

abstract class MemberRepository extends ChangeNotifier {
  Future<Result<List<MemberModel>>> getMemberList();

  Future<Result<MemberModel>> getMember(int id);

  Future<Result<MemberModel>> createMember(MemberModel member);

  Future<Result<MemberModel>> updateMember(MemberModel member);

  Future<Result<void>> deleteMember(int id);
}
