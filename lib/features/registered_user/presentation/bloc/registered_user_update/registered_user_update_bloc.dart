import 'package:carpark/features/registered_user/domain/models/update_registered_user_request.dart';
import 'package:carpark/features/registered_user/domain/usecases/registered_user_update_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registered_user_update_event.dart';
part 'registered_user_update_state.dart';

class RegisteredUserUpdateBloc
    extends Bloc<RegisteredUserUpdateEvent, RegisteredUserUpdateState> {
  final RegisteredUserUpdateUsecase updateUsercase;

  RegisteredUserUpdateBloc(this.updateUsercase)
      : super(const RegisteredUserUpdateState()) {
    on<Initial>(_onInitial);
    on<UpdateRegisteredUser>(_updateRegisteredUser);
  }

  Future<void> _onInitial(
      Initial event, Emitter<RegisteredUserUpdateState> emit) async {
    emit(state.copyWith(
        status: RegisteredUserUpdateStatus.initial,
        id: 0,
        idCard: "",
        engName: "",
        thaiName: "",
        birthdate: "",
        gender: "",
        address: "",
        telephone: "",
        type: "",
        expiredDate: "",
        photoUrl: ""));
  }

  Future<void> _updateRegisteredUser(UpdateRegisteredUser event,
      Emitter<RegisteredUserUpdateState> emit) async {
    emit(state.copyWith(status: RegisteredUserUpdateStatus.updating));
    try {
      final registeredUser = await updateUsercase.call(event.request);
      registeredUser.fold(
        (l) => emit(state.copyWith(
            status: RegisteredUserUpdateStatus.updateFailure,
            message: l.message)),
        (r) {
          emit(state.copyWith(
              status: RegisteredUserUpdateStatus.updateSuccess,
              id: r.id,
              idCard: r.idCard,
              engName: r.engName,
              thaiName: r.thaiName,
              birthdate: r.birthdate,
              gender: r.gender,
              address: r.address,
              telephone: r.telephone,
              type: r.type,
              expiredDate: r.expiredDate.toDateString()));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          status: RegisteredUserUpdateStatus.updateFailure,
          message: e.toString()));
    }
  }
}
