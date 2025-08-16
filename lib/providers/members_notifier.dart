import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain/models/member/member_model.dart';

class MembersNotifier extends StateNotifier<List<MemberModel>> {
  MembersNotifier() : super(const []);

  void setState(List<MemberModel> members) {
    state = members;
  }
}
