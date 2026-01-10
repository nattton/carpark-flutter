import 'package:carpark/features/registered_user/models/registered_user.dart';
import 'package:carpark/features/registered_user/use_cases/registered_user_check_out_usecase.dart';
import 'package:carpark/shared/services/api/model/registered_user/registered_user_check_out_request.dart';
import 'package:carpark/shared/utils/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'registered_user_check_out_event.dart';
part 'registered_user_check_out_state.dart';

@Injectable()
class RegisteredUserCheckOutBloc
    extends Bloc<RegisteredUserCheckOutEvent, RegisteredUserCheckOutState> {
  RegisteredUserCheckOutBloc(this.registeredUserCheckOutUsecase)
    : super(RegisteredUserCheckOutInitial()) {
    on<RegisteredUserCheckOutEvent>((event, emit) {});
    on<PostRegisteredUserCheckOutEvent>((event, emit) async {
      emit(RegisteredUserCheckOutLoading());
      final result = await registeredUserCheckOutUsecase.call(
        RegisteredUserCheckOutRequest(generatedId: event.generatedId),
      );
      result.fold(
        (failure) => emit(RegisteredUserCheckOutFailure(failure: failure)),
        (registeredUser) =>
            emit(RegisteredUserCheckOutSuccess(registeredUser: registeredUser)),
      );
    });
  }
  final RegisteredUserCheckOutUsecase registeredUserCheckOutUsecase;
}
