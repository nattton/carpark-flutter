import 'dart:io';

import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:carpark/features/registered_user/use_cases/read_id_card_usecase.dart';
import 'package:carpark/features/registered_user/use_cases/registered_user_add_photo_usecase.dart';
import 'package:carpark/features/registered_user/use_cases/registered_user_create_usecase.dart';
import 'package:carpark/shared/services/api/model/registered_user/add_photo_registered_user_params.dart';
import 'package:carpark/shared/services/api/model/registered_user/create_registered_user_request.dart';
import 'package:carpark/shared/utils/usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

part 'registered_user_create_event.dart';
part 'registered_user_create_state.dart';

@Injectable()
class RegisteredUserCreateBloc
    extends BlocSignal<RegisteredUserCreateEvent, RegisteredUserCreateState> {
  RegisteredUserCreateBloc(
    this.usercase,
    this.readIdCardUsecase,
    this.addPhotoUsecase,
  ) : super(initialState: const RegisteredUserCreateState()) {
    on<InitialCreateRegisteredUser>(_onInitial);
    on<ReadIdCard>(_readIdCard);
    on<SavePhoto>(_savePhoto);
    on<CreateRegisteredUser>(_createRegisteredUser);
    on<SelectExpiredDate>(_selectExpiredDate);
  }
  final RegisteredUserCreateUsecase usercase;
  final ReadIdCardUsecase readIdCardUsecase;
  final RegisteredUserAddPhotoUsecase addPhotoUsecase;

  Future<void> _onInitial(
    InitialCreateRegisteredUser event,
    void Function(RegisteredUserCreateState) emit,
  ) async {
    emit(
      stateValue.copyWith(
        status: RegisteredUserCreateStatus.initial,
        id: 0,
        idCard: '',
        engName: '',
        thaiName: '',
        birthdate: '',
        gender: '',
        address: '',
        telephone: '',
        type: '',
        expiredDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        photoUrl: '',
      ),
    );
  }

  Future<void> _readIdCard(
    ReadIdCard event,
    void Function(RegisteredUserCreateState) emit,
  ) async {
    emit(stateValue.copyWith(status: RegisteredUserCreateStatus.reading));
    final idCardResponse = await readIdCardUsecase.call(NoParams());
    idCardResponse.fold(
      (l) => emit(
        stateValue.copyWith(
          status: RegisteredUserCreateStatus.readFailure,
          message: l.message,
        ),
      ),
      (r) => emit(
        stateValue.copyWith(
          status: RegisteredUserCreateStatus.readSuccess,
          idCard: r.id,
          engName: r.engName,
          thaiName: r.thaiName,
          birthdate: r.birthdate,
          gender: r.genderName(),
          address: r.address,
          photoUrl: r.photoUrl(),
        ),
      ),
    );
  }

  Future<void> _createRegisteredUser(
    CreateRegisteredUser event,
    void Function(RegisteredUserCreateState) emit,
  ) async {
    emit(stateValue.copyWith(status: RegisteredUserCreateStatus.creating));
    try {
      final registeredUser = await usercase.call(event.request);
      registeredUser.fold(
        (l) => emit(
          stateValue.copyWith(
            status: RegisteredUserCreateStatus.createFailure,
            message: l.message,
          ),
        ),
        (r) {
          emit(
            stateValue.copyWith(
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
              expiredDate: r.expiredDate.toDateString(),
            ),
          );
          add(SavePhoto());
        },
      );
    } catch (e) {
      emit(
        stateValue.copyWith(
          status: RegisteredUserCreateStatus.createFailure,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _savePhoto(
    SavePhoto event,
    void Function(RegisteredUserCreateState) emit,
  ) async {
    if (stateValue.photoUrl.isNotEmpty) {
      emit(stateValue.copyWith(status: RegisteredUserCreateStatus.savingPhoto));
      try {
        final photoFile = await _tempImage(stateValue.idCard);
        await Dio().download(stateValue.photoUrl, photoFile.path);
        await addPhotoUsecase.call(
          AddPhotoRegisteredUserParam(id: stateValue.id, photo: photoFile),
        );
        emit(
          stateValue.copyWith(
            status: RegisteredUserCreateStatus.savePhotoSuccess,
          ),
        );
      } catch (e) {
        emit(
          stateValue.copyWith(
            status: RegisteredUserCreateStatus.savePhotoFailure,
            message: e.toString(),
          ),
        );
      }
    }
  }

  Future<File> _tempImage(String type) async {
    final directory = await getTemporaryDirectory();

    return File('${directory.path}/$type.jpg');
  }

  Future<void> _selectExpiredDate(
    SelectExpiredDate event,
    void Function(RegisteredUserCreateState) emit,
  ) async {
    emit(
      stateValue.copyWith(
        status: RegisteredUserCreateStatus.selectingExpiredDate,
      ),
    );
    emit(
      stateValue.copyWith(
        status: RegisteredUserCreateStatus.selectExpiredDateSuccess,
        expiredDate: _formatDate(event.expiredDates[0]!),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
