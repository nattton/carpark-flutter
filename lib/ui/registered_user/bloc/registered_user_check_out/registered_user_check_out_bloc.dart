import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/services/api/model/registered_user/registered_user_check_out_request.dart';
import '../../../../domain/models/registered_user/registered_user.dart';
import '../../../../domain/use_cases/registered_user/registered_user_check_out_usecase.dart';
import '../../../../utils/failures.dart';

part 'registered_user_check_out_event.dart';
part 'registered_user_check_out_state.dart';

@Injectable()
class RegisteredUserCheckOutBloc
    extends Bloc<RegisteredUserCheckOutEvent, RegisteredUserCheckOutState> {
  final RegisteredUserCheckOutUsecase registeredUserCheckOutUsecase;
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
}
