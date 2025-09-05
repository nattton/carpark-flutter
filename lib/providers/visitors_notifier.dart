import 'package:hooks_riverpod/legacy.dart';

import '../models/visitor_model.dart';

class VisitorsNotifier extends StateNotifier<List<VisitorModel>> {
  VisitorsNotifier() : super(const []);

  void setState(List<VisitorModel> visitors) {
    state = visitors;
  }
}
