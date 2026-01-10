import 'package:carpark/features/registered_user/models/registered_user.dart';
import 'package:carpark/features/registered_user/use_cases/registered_user_check_in_usecase.dart';
import 'package:carpark/shared/services/api/model/registered_user/registered_user_check_in_request.dart';
import 'package:carpark/shared/utils/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

part 'registered_user_check_in_event.dart';
part 'registered_user_check_in_state.dart';

@Injectable()
class RegisteredUserCheckInBloc
    extends Bloc<RegisteredUserCheckInEvent, RegisteredUserCheckInState> {
  RegisteredUserCheckInBloc(this.registeredUserCheckInUsecase)
    : super(RegisteredUserCheckInInitial()) {
    on<RegisteredUserCheckInEvent>((event, emit) {});

    on<PostRegisteredUserCheckInEvent>((event, emit) async {
      emit(RegisteredUserCheckInLoading());
      if (event.generatedId.isEmpty) {
        emit(
          RegisteredUserCheckInFailure(
            failure: Failure('Generated ID is required'),
          ),
        );
        return;
      }
      if (!Uuid.isValidUUID(fromString: event.generatedId)) {
        emit(RegisteredUserCheckInFailure(failure: Failure('รหัสไม่ถูกต้อง')));
        return;
      }
      final result = await registeredUserCheckInUsecase.call(
        RegisteredUserCheckInRequest(generatedId: event.generatedId),
      );
      result.fold(
        (failure) => emit(RegisteredUserCheckInFailure(failure: failure)),
        (registeredUser) =>
            emit(RegisteredUserCheckInSuccess(registeredUser: registeredUser)),
      );
    });
  }
  final RegisteredUserCheckInUsecase registeredUserCheckInUsecase;
}
