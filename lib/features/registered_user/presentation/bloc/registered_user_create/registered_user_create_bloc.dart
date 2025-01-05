import 'dart:io';

import 'package:carpark/features/registered_user/domain/models/create_registered_user_request.dart';
import 'package:carpark/features/registered_user/domain/usecases/registered_user_create_usecase.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

part 'registered_user_create_event.dart';
part 'registered_user_create_state.dart';

class RegisteredUserCreateBloc
    extends Bloc<RegisteredUserCreateEvent, RegisteredUserCreateState> {
  final RegisteredUserCreateUsecase usercase;

  RegisteredUserCreateBloc(this.usercase)
      : super(const RegisteredUserCreateState()) {
    on<Initial>(_onInitial);
    on<ReadSmartCard>(_readSmartCard);
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
        photoPath: ""));
  }

  Future<void> _readSmartCard(
      ReadSmartCard event, Emitter<RegisteredUserCreateState> emit) async {
    emit(state.copyWith(status: RegisteredUserCreateStatus.reading));
    try {
      final idCardResponse = await sl<ApiService>().smartCardReader();
      final photoFile = await _tempImage(idCardResponse.id);
      await sl<Dio>().download(idCardResponse.photoUrl(), photoFile.path);
      emit(state.copyWith(
          status: RegisteredUserCreateStatus.readSuccess,
          id: idCardResponse.id,
          engName: idCardResponse.engName,
          thaiName: idCardResponse.thaiName,
          birthdate: idCardResponse.birthdate,
          gender: idCardResponse.gender,
          address: idCardResponse.address,
          photoPath: photoFile.path));
    } catch (e) {
      emit(state.copyWith(
          status: RegisteredUserCreateStatus.readFailure,
          id: "",
          engName: "",
          thaiName: "",
          birthdate: "",
          gender: "",
          address: "",
          photoPath: "",
          telephone: ""));
    }
  }

  Future<File> _tempImage(String type) async {
    final directory = await getTemporaryDirectory();

    return File('${directory.path}/$type.jpg');
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
