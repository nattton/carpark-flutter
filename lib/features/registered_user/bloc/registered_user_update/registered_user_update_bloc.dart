import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:carpark/features/registered_user/models/registered_user.dart';
import 'package:carpark/features/registered_user/models/registered_user_model.dart';
import 'package:carpark/features/registered_user/use_cases/registered_user_get_usecase.dart';
import 'package:carpark/features/registered_user/use_cases/registered_user_update_usecase.dart';
import 'package:carpark/shared/models/null_time_model.dart';
import 'package:carpark/shared/services/api/model/registered_user/update_registered_user_request.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'registered_user_update_event.dart';
part 'registered_user_update_state.dart';

@Injectable()
class RegisteredUserUpdateBloc
    extends BlocSignal<RegisteredUserUpdateEvent, RegisteredUserUpdateState> {
  RegisteredUserUpdateBloc(this.readUsercase, this.updateUsercase)
    : super(initialState: const RegisteredUserUpdateState()) {
    on<GetRegisteredUser>(_getRegisteredUser);
    on<UpdateRegisteredUser>(_updateRegisteredUser);
    on<UpdateRegisteredUserSelectExpiredDate>(_selectExpiredDate);
    on<UpdateRegisteredUserSelectType>(_selectType);
  }
  final RegisteredUserGetUsecase readUsercase;
  final RegisteredUserUpdateUsecase updateUsercase;

  Future<void> _getRegisteredUser(
    GetRegisteredUser event,
    void Function(RegisteredUserUpdateState) emit,
  ) async {
    emit(stateValue.copyWith(status: RegisteredUserUpdateStatus.loading));
    final registeredUser = await readUsercase.call(event.id);
    registeredUser.fold(
      (l) => emit(
        stateValue.copyWith(
          status: RegisteredUserUpdateStatus.loadFailure,
          message: l.message,
        ),
      ),
      (r) {
        emit(
          stateValue.copyWith(
            status: RegisteredUserUpdateStatus.loadSuccess,
            registeredUser: RegisteredUserModel.responseMapper(r),
          ),
        );
      },
    );
  }

  Future<void> _updateRegisteredUser(
    UpdateRegisteredUser event,
    void Function(RegisteredUserUpdateState) emit,
  ) async {
    emit(stateValue.copyWith(status: RegisteredUserUpdateStatus.updating));
    try {
      final registeredUser = await updateUsercase.call(event.request);
      registeredUser.fold(
        (l) => emit(
          stateValue.copyWith(
            status: RegisteredUserUpdateStatus.updateFailure,
            message: l.message,
          ),
        ),
        (r) {
          emit(
            stateValue.copyWith(
              status: RegisteredUserUpdateStatus.updateSuccess,
              registeredUser: r,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        stateValue.copyWith(
          status: RegisteredUserUpdateStatus.updateFailure,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _selectExpiredDate(
    UpdateRegisteredUserSelectExpiredDate event,
    void Function(RegisteredUserUpdateState) emit,
  ) async {
    emit(
      stateValue.copyWith(
        status: RegisteredUserUpdateStatus.selectingExpiredDate,
      ),
    );
    emit(
      stateValue.copyWith(
        status: RegisteredUserUpdateStatus.selectExpiredDateSuccess,
        registeredUser: stateValue.registeredUser.copyWith(
          expiredDate: NullTimeModel(valid: true, time: event.expiredDates[0]),
        ),
      ),
    );
  }

  Future<void> _selectType(
    UpdateRegisteredUserSelectType event,
    void Function(RegisteredUserUpdateState) emit,
  ) async {
    emit(
      stateValue.copyWith(
        status: RegisteredUserUpdateStatus.selectType,
        registeredUser: stateValue.registeredUser.copyWith(type: event.type),
      ),
    );
  }
}
