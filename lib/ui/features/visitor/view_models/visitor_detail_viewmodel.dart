import 'package:carpark/data/repositories/visitor/visitor_repository.dart';
import 'package:carpark/domain/models/visitor_model.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class VisitorDetailViewModel extends ChangeNotifier {
  new({required VisitorRepository visitorRepository})
    : _visitorRepository = visitorRepository;

  final VisitorRepository _visitorRepository;
  final _log = Logger('VisitorDetailViewModel');

  late final Command<int, VisitorModel> getVisitorCommand =
      Command.createAsync<int, VisitorModel>(
        initialValue: VisitorModel.empty(),
        (visitorId) async {
          if (visitorId <= 0) {
            return VisitorModel.empty();
          }
          final result = await _visitorRepository.getVisitor(visitorId);
          switch (result) {
            case Ok<VisitorModel>():
              return result.value;
            case Error<VisitorModel>():
              _log.warning('getVisitor failed! ${result.error}');
              throw result.error;
          }
        },
      );
}
