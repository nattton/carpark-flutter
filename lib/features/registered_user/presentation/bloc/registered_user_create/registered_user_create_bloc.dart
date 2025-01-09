import 'dart:io';

import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/models/add_photo_registered_user_params.dart';
import 'package:carpark/features/registered_user/domain/models/create_registered_user_request.dart';
import 'package:carpark/features/registered_user/domain/usecases/read_id_card_usecase.dart';
import 'package:carpark/features/registered_user/domain/usecases/registered_user_add_photo_usecase.dart';
import 'package:carpark/features/registered_user/domain/usecases/registered_user_create_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

part 'registered_user_create_event.dart';
part 'registered_user_create_state.dart';

@Injectable()
class RegisteredUserCreateBloc
    extends Bloc<RegisteredUserCreateEvent, RegisteredUserCreateState> {
  final RegisteredUserCreateUsecase usercase;
  final ReadIdCardUsecase readIdCardUsecase;
  final RegisteredUserAddPhotoUsecase addPhotoUsecase;

  RegisteredUserCreateBloc(
      this.usercase, this.readIdCardUsecase, this.addPhotoUsecase)
      : super(const RegisteredUserCreateState()) {
    on<InitialCreateRegisteredUser>(_onInitial);
    on<ReadIdCard>(_readIdCard);
    on<SavePhoto>(_savePhoto);
    on<CreateRegisteredUser>(_createRegisteredUser);
    on<SelectExpiredDate>(_selectExpiredDate);
  }

  Future<void> _onInitial(InitialCreateRegisteredUser event,
      Emitter<RegisteredUserCreateState> emit) async {
    emit(state.copyWith(
      status: RegisteredUserCreateStatus.initial,
      id: 0,
      idCard: "",
      engName: "",
      thaiName: "",
      birthdate: "",
      gender: "",
      address: "",
      telephone: "",
      type: "",
      expiredDate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
      photoUrl: "",
    ));
  }

  Future<void> _readIdCard(
      ReadIdCard event, Emitter<RegisteredUserCreateState> emit) async {
    emit(state.copyWith(status: RegisteredUserCreateStatus.reading));
    final idCardResponse = await readIdCardUsecase.call(NoParams());
    idCardResponse.fold(
        (l) => emit(state.copyWith(
            status: RegisteredUserCreateStatus.readFailure,
            message: l.message)),
        (r) => emit(state.copyWith(
              status: RegisteredUserCreateStatus.readSuccess,
              idCard: r.id,
              engName: r.engName,
              thaiName: r.thaiName,
              birthdate: r.birthdate,
              gender: r.genderName(),
              address: r.address,
              photoUrl: r.photoUrl(),
            )));
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
        (r) {
          emit(state.copyWith(
              status: RegisteredUserCreateStatus.createSuccess,
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
          add(SavePhoto());
        },
      );
    } catch (e) {
      emit(state.copyWith(
          status: RegisteredUserCreateStatus.createFailure,
          message: e.toString()));
    }
  }

  Future<void> _savePhoto(
      SavePhoto event, Emitter<RegisteredUserCreateState> emit) async {
    if (state.photoUrl.isNotEmpty) {
      emit(state.copyWith(status: RegisteredUserCreateStatus.savingPhoto));
      try {
        final photoFile = await _tempImage(state.idCard);
        await Dio().download(state.photoUrl, photoFile.path);
        await addPhotoUsecase
            .call(AddPhotoRegisteredUserParam(id: state.id, photo: photoFile));
        emit(state.copyWith(
            status: RegisteredUserCreateStatus.savePhotoSuccess));
      } catch (e) {
        emit(state.copyWith(
            status: RegisteredUserCreateStatus.savePhotoFailure,
            message: e.toString()));
      }
    }
  }

  Future<File> _tempImage(String type) async {
    final directory = await getTemporaryDirectory();

    return File('${directory.path}/$type.jpg');
  }

  Future<void> _selectExpiredDate(
      SelectExpiredDate event, Emitter<RegisteredUserCreateState> emit) async {
    emit(state.copyWith(
        status: RegisteredUserCreateStatus.selectingExpiredDate));
    emit(state.copyWith(
        status: RegisteredUserCreateStatus.selectExpiredDateSuccess,
        expiredDate: _formatDate(event.expiredDates[0]!)));
  }

  String _formatDate(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }
}
