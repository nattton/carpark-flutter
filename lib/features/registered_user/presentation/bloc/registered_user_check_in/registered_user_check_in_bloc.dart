import 'package:carpark/core/error/failures.dart';
import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_check_in_request.dart';
import 'package:carpark/features/registered_user/domain/usecases/registered_user_check_in_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registered_user_check_in_event.dart';
part 'registered_user_check_in_state.dart';

class RegisteredUserCheckInBloc
    extends Bloc<RegisteredUserCheckInEvent, RegisteredUserCheckInState> {
  final RegisteredUserCheckInUsecase registeredUserCheckInUsecase;
  RegisteredUserCheckInBloc(this.registeredUserCheckInUsecase)
      : super(RegisteredUserCheckInInitial()) {
    on<RegisteredUserCheckInEvent>((event, emit) {});

    on<PostRegisteredUserCheckInEvent>((event, emit) async {
      emit(RegisteredUserCheckInLoading());
      final result = await registeredUserCheckInUsecase
          .call(RegisteredUserCheckInRequest(generatedId: event.generatedId));
      result.fold(
          (failure) => emit(RegisteredUserCheckInFailure(failure: failure)),
          (registeredUser) => emit(
              RegisteredUserCheckInSuccess(registeredUser: registeredUser)));
    });
  }
}
