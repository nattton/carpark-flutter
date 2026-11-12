import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:carpark/features/registered_user/models/registered_user_log.dart';
import 'package:carpark/features/registered_user/use_cases/get_registered_user_log_not_check_out_response.dart';
import 'package:carpark/shared/utils/failures.dart';
import 'package:carpark/shared/utils/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'registered_user_not_check_out_event.dart';
part 'registered_user_not_check_out_state.dart';

@Injectable()
class RegisteredUserNotCheckOutBloc
    extends
        BlocSignal<
          RegisteredUserNotCheckOutEvent,
          RegisteredUserNotCheckOutState
        > {
  RegisteredUserNotCheckOutBloc(
    this.getRegisteredUserLogNotCheckOutResponseUsecase,
  ) : super(initialState: RegisteredUserNotCheckOutInitial()) {
    on<RegisteredUserNotCheckOutEvent>((event, emit) {});
    on<GetRegisteredUserNotCheckOut>(_onGetRegisteredUserNotCheckOut);
  }
  final GetRegisteredUserLogNotCheckOutResponseUsecase
  getRegisteredUserLogNotCheckOutResponseUsecase;

  Future<void> _onGetRegisteredUserNotCheckOut(
    GetRegisteredUserNotCheckOut event,
    void Function(RegisteredUserNotCheckOutState) emit,
  ) async {
    emit(RegisteredUserNotCheckOutLoading());
    final result = await getRegisteredUserLogNotCheckOutResponseUsecase.call(
      NoParams(),
    );
    result.fold(
      (failure) {
        emit(RegisteredUserNotCheckOutError(failure));
      },
      (response) {
        emit(RegisteredUserNotCheckOutLoaded(response));
      },
    );
  }
}
