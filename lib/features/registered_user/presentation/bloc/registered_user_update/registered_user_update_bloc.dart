import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../models/null_time_model.dart';
import '../../../data/models/registered_user_model.dart';
import '../../../domain/entity/registered_user.dart';
import '../../../domain/models/update_registered_user_request.dart';
import '../../../domain/usecases/registered_user_get_usecase.dart';
import '../../../domain/usecases/registered_user_update_usecase.dart';

part 'registered_user_update_event.dart';
part 'registered_user_update_state.dart';

@Injectable()
class RegisteredUserUpdateBloc
    extends Bloc<RegisteredUserUpdateEvent, RegisteredUserUpdateState> {
  final RegisteredUserGetUsecase readUsercase;
  final RegisteredUserUpdateUsecase updateUsercase;

  RegisteredUserUpdateBloc(this.readUsercase, this.updateUsercase)
    : super(const RegisteredUserUpdateState()) {
    on<GetRegisteredUser>(_getRegisteredUser);
    on<UpdateRegisteredUser>(_updateRegisteredUser);
    on<UpdateRegisteredUserSelectExpiredDate>(_selectExpiredDate);
    on<UpdateRegisteredUserSelectType>(_selectType);
  }

  Future<void> _getRegisteredUser(
    GetRegisteredUser event,
    Emitter<RegisteredUserUpdateState> emit,
  ) async {
    emit(state.copyWith(status: RegisteredUserUpdateStatus.loading));
    final registeredUser = await readUsercase.call(event.id);
    registeredUser.fold(
      (l) => emit(
        state.copyWith(
          status: RegisteredUserUpdateStatus.loadFailure,
          message: l.message,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            status: RegisteredUserUpdateStatus.loadSuccess,
            registeredUser: RegisteredUserModel.responseMapper(r),
          ),
        );
      },
    );
  }

  Future<void> _updateRegisteredUser(
    UpdateRegisteredUser event,
    Emitter<RegisteredUserUpdateState> emit,
  ) async {
    emit(state.copyWith(status: RegisteredUserUpdateStatus.updating));
    try {
      final registeredUser = await updateUsercase.call(event.request);
      registeredUser.fold(
        (l) => emit(
          state.copyWith(
            status: RegisteredUserUpdateStatus.updateFailure,
            message: l.message,
          ),
        ),
        (r) {
          emit(
            state.copyWith(
              status: RegisteredUserUpdateStatus.updateSuccess,
              registeredUser: r,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RegisteredUserUpdateStatus.updateFailure,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _selectExpiredDate(
    UpdateRegisteredUserSelectExpiredDate event,
    Emitter<RegisteredUserUpdateState> emit,
  ) async {
    emit(
      state.copyWith(status: RegisteredUserUpdateStatus.selectingExpiredDate),
    );
    emit(
      state.copyWith(
        status: RegisteredUserUpdateStatus.selectExpiredDateSuccess,
        registeredUser: state.registeredUser.copyWith(
          expiredDate: NullTimeModel(valid: true, time: event.expiredDates[0]!),
        ),
      ),
    );
  }

  Future<void> _selectType(
    UpdateRegisteredUserSelectType event,
    Emitter<RegisteredUserUpdateState> emit,
  ) async {
    emit(
      state.copyWith(
        status: RegisteredUserUpdateStatus.selectType,
        registeredUser: state.registeredUser.copyWith(type: event.type),
      ),
    );
  }
}
