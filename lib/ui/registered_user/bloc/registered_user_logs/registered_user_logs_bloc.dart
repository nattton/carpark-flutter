import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/models/registered_user/registered_user.dart';
import '../../../../domain/models/registered_user/registered_user_log.dart';
import '../../../../domain/use_cases/registered_user/get_registered_user_logs_usecase.dart';

part 'registered_user_logs_event.dart';
part 'registered_user_logs_state.dart';

@Injectable()
class RegisteredUserLogsBloc
    extends Bloc<RegisteredUserLogsEvent, RegisteredUserLogsState> {
  final GetRegisteredUserLogsUsecase usecase;
  RegisteredUserLogsBloc(this.usecase) : super(RegisteredUserLogsInitial()) {
    on<GetRegisteredUserLogs>(_onGetRegisteredUserLogs);
  }

  Future<void> _onGetRegisteredUserLogs(
    GetRegisteredUserLogs event,
    Emitter<RegisteredUserLogsState> emit,
  ) async {
    emit(RegisteredUserLogsLoading());
    final result = await usecase.call(event.userId);
    result.fold(
      (failure) {
        emit(RegisteredUserLogsFailure(failure.message));
      },
      (logs) {
        emit(RegisteredUserLogsSuccess(logs.user, logs.logs));
      },
    );
  }
}
