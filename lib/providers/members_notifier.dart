import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/member_model.dart';

class MembersNotifier extends StateNotifier<List<MemberModel>> {
  MembersNotifier() : super(const []);

  void setState(List<MemberModel> members) {
    state = members;
  }
}
