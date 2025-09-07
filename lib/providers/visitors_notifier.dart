import 'package:carpark/models/visitor_model.dart';
import 'package:hooks_riverpod/legacy.dart';

class VisitorsNotifier extends StateNotifier<List<VisitorModel>> {
  VisitorsNotifier() : super(const []);

  void setState(List<VisitorModel> visitors) {
    state = visitors;
  }
}
