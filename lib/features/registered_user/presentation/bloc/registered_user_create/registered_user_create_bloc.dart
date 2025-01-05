import 'dart:io';

import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/models/create_registered_user_request.dart';
import 'package:carpark/features/registered_user/domain/usecases/read_id_card_usecase.dart';
import 'package:carpark/features/registered_user/domain/usecases/registered_user_create_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

part 'registered_user_create_event.dart';
part 'registered_user_create_state.dart';

class RegisteredUserCreateBloc
    extends Bloc<RegisteredUserCreateEvent, RegisteredUserCreateState> {
  final RegisteredUserCreateUsecase usercase;
  final ReadIdCardUsecase readIdCardUsecase;

  RegisteredUserCreateBloc(this.usercase, this.readIdCardUsecase)
      : super(const RegisteredUserCreateState()) {
    on<Initial>(_onInitial);
    on<ReadIdCard>(_readIdCard);
    on<SavePhoto>(_savePhoto);
    on<CreateRegisteredUser>(_createRegisteredUser);
  }

  Future<void> _onInitial(
      Initial event, Emitter<RegisteredUserCreateState> emit) async {
    emit(state.copyWith(
        status: RegisteredUserCreateStatus.initial,
        id: "",
        idCard: "",
        engName: "",
        thaiName: "",
        birthdate: "",
        gender: "",
        address: "",
        telephone: "",
        type: "",
        expiredDate: "",
        photoPath: "",
        photoUrl: ""));
  }

  Future<void> _readIdCard(
      ReadIdCard event, Emitter<RegisteredUserCreateState> emit) async {
    emit(state.copyWith(status: RegisteredUserCreateStatus.reading));
    final idCardResponse = await readIdCardUsecase.call(NoParams());
    idCardResponse.fold(
        (l) => emit(state.copyWith(
            status: RegisteredUserCreateStatus.readFailure,
            message: l.message)), (r) {
      emit(state.copyWith(
        status: RegisteredUserCreateStatus.readSuccess,
        id: r.id,
        engName: r.engName,
        thaiName: r.thaiName,
        birthdate: r.birthdate,
        gender: r.gender,
        address: r.address,
        photoUrl: r.photoUrl(),
      ));
      add(SavePhoto());
    });
  }

  Future<File> _tempImage(String type) async {
    final directory = await getTemporaryDirectory();

    return File('${directory.path}/$type.jpg');
  }

  Future<void> _savePhoto(
      SavePhoto event, Emitter<RegisteredUserCreateState> emit) async {
    emit(state.copyWith(status: RegisteredUserCreateStatus.reading));
    final photoFile = await _tempImage(state.id);
    await Dio().download(state.photoUrl, photoFile.path);
    emit(state.copyWith(
        status: RegisteredUserCreateStatus.readSuccess,
        photoPath: photoFile.path));
  }

  Future<void> _createRegisteredUser(CreateRegisteredUser event,
      Emitter<RegisteredUserCreateState> emit) async {
    emit(state.copyWith(status: RegisteredUserCreateStatus.creating));
    try {
      final registeredUser = await usercase.call(event.request);
      registeredUser.fold(
        (l) => emit(state.copyWith(
            status: RegisteredUserCreateStatus.createFailure,
            message: l.message)),
        (r) => emit(state.copyWith(
            status: RegisteredUserCreateStatus.createSuccess,
            idCard: r.idCard,
            engName: r.engName,
            thaiName: r.thaiName,
            birthdate: r.birthdate,
            gender: r.gender,
            address: r.address,
            telephone: r.telephone,
            type: r.type,
            expiredDate: r.expiredDate.toDateString())),
      );
    } catch (e) {
      emit(state.copyWith(
          status: RegisteredUserCreateStatus.createFailure,
          message: e.toString()));
    }
  }
}
