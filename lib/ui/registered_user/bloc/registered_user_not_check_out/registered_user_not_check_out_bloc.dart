import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/models/registered_user/registered_user_log.dart';
import '../../../../domain/use_cases/registered_user/get_registered_user_log_not_check_out_response.dart';
import '../../../../utils/failures.dart';
import '../../../../utils/usecase.dart';

part 'registered_user_not_check_out_event.dart';
part 'registered_user_not_check_out_state.dart';

@Injectable()
class RegisteredUserNotCheckOutBloc
    extends
        Bloc<RegisteredUserNotCheckOutEvent, RegisteredUserNotCheckOutState> {
  final GetRegisteredUserLogNotCheckOutResponseUsecase
  getRegisteredUserLogNotCheckOutResponseUsecase;

  RegisteredUserNotCheckOutBloc(
    this.getRegisteredUserLogNotCheckOutResponseUsecase,
  ) : super(RegisteredUserNotCheckOutInitial()) {
    on<RegisteredUserNotCheckOutEvent>((event, emit) {});
    on<GetRegisteredUserNotCheckOut>(_onGetRegisteredUserNotCheckOut);
  }

  Future<void> _onGetRegisteredUserNotCheckOut(
    GetRegisteredUserNotCheckOut event,
    Emitter<RegisteredUserNotCheckOutState> emit,
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
