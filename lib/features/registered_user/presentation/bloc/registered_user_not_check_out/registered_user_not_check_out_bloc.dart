import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/entity/registered_user_log.dart';
import 'package:carpark/features/registered_user/domain/usecases/get_registered_user_log_not_check_out_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'registered_user_not_check_out_event.dart';
part 'registered_user_not_check_out_state.dart';

@Injectable()
class RegisteredUserNotCheckOutBloc extends Bloc<RegisteredUserNotCheckOutEvent,
    RegisteredUserNotCheckOutState> {
  final GetRegisteredUserLogNotCheckOutResponseUsecase
      getRegisteredUserLogNotCheckOutResponseUsecase;

  RegisteredUserNotCheckOutBloc(
      this.getRegisteredUserLogNotCheckOutResponseUsecase)
      : super(RegisteredUserNotCheckOutInitial()) {
    on<RegisteredUserNotCheckOutEvent>((event, emit) {});
    on<GetRegisteredUserNotCheckOut>(_onGetRegisteredUserNotCheckOut);
  }

  Future<void> _onGetRegisteredUserNotCheckOut(
      GetRegisteredUserNotCheckOut event,
      Emitter<RegisteredUserNotCheckOutState> emit) async {
    emit(RegisteredUserNotCheckOutLoading());
    final result =
        await getRegisteredUserLogNotCheckOutResponseUsecase.call(NoParams());
    result.fold((failure) {
      emit(RegisteredUserNotCheckOutError(failure));
    }, (response) {
      emit(RegisteredUserNotCheckOutLoaded(response));
    });
  }
}
