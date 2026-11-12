import 'dart:io';

import 'package:carpark/data/models/registered_user/create_registered_user_request.dart';
import 'package:carpark/data/repositories/card_reader/id_card_service_repository.dart';
import 'package:carpark/data/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/domain/models/id_card_entity.dart';
import 'package:carpark/domain/models/registered_user_model.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

enum RegisteredUserCreateStatus {
  initial,
  reading,
  readSuccess,
  readFailure,
  creating,
  createSuccess,
  createFailure,
  savingPhoto,
  savePhotoSuccess,
  savePhotoFailure,
  selectingExpiredDate,
  selectExpiredDateSuccess,
  failure,
}

@Injectable()
class RegisteredUserCreateViewModel extends ChangeNotifier {
  new({
    required RegisteredUserServiceRepository repository,
    required IdCardServiceRepository idCardRepository,
  }) : _repository = repository,
       _idCardRepository = idCardRepository;

  final RegisteredUserServiceRepository _repository;
  final IdCardServiceRepository _idCardRepository;

  RegisteredUserCreateStatus status = RegisteredUserCreateStatus.initial;
  int id = 0;
  String idCard = '';
  String engName = '';
  String thaiName = '';
  String birthdate = '';
  String gender = '';
  String address = '';
  String telephone = '';
  String type = '';
  String expiredDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String photoUrl = '';
  String message = '';

  void initialize() {
    status = RegisteredUserCreateStatus.initial;
    id = 0;
    idCard = '';
    engName = '';
    thaiName = '';
    birthdate = '';
    gender = '';
    address = '';
    telephone = '';
    type = '';
    expiredDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    photoUrl = '';
    message = '';
    notifyListeners();
  }

  Future<Result<IDCardEntity>> readIdCard() async {
    status = RegisteredUserCreateStatus.reading;
    notifyListeners();

    final result = await _idCardRepository.readIdCard();
    switch (result) {
      case Ok<IDCardEntity>():
        final r = result.value;
        status = RegisteredUserCreateStatus.readSuccess;
        idCard = r.id;
        engName = r.engName;
        thaiName = r.thaiName;
        birthdate = r.birthdate;
        gender = r.genderName();
        address = r.address;
        photoUrl = r.photoUrl();
      case Error<IDCardEntity>():
        status = RegisteredUserCreateStatus.readFailure;
        message = result.error.toString();
    }
    notifyListeners();
    return result;
  }

  Future<Result<RegisteredUserModel>> createRegisteredUser(
    CreateRegisteredUserRequest request,
  ) async {
    status = RegisteredUserCreateStatus.creating;
    notifyListeners();

    final result = await _repository.createRegisteredUser(request);
    switch (result) {
      case Ok<RegisteredUserModel>():
        final r = result.value;
        status = RegisteredUserCreateStatus.createSuccess;
        id = r.id;
        idCard = r.idCard;
        engName = r.engName;
        thaiName = r.thaiName;
        birthdate = r.birthdate;
        gender = r.gender;
        address = r.address;
        telephone = r.telephone;
        type = r.type;
        expiredDate = r.expiredDate?.toDateString() ?? '';
        notifyListeners();
        await savePhoto();
      case Error<RegisteredUserModel>():
        status = RegisteredUserCreateStatus.createFailure;
        message = result.error.toString();
        notifyListeners();
    }
    return result;
  }

  Future<void> savePhoto() async {
    if (photoUrl.isNotEmpty) {
      status = RegisteredUserCreateStatus.savingPhoto;
      notifyListeners();
      try {
        final photoFile = await _tempImage(idCard);
        final downloadResult = await _idCardRepository.downloadPhoto(
          photoUrl,
          photoFile.path,
        );
        if (downloadResult is Error<void>) {
          status = RegisteredUserCreateStatus.savePhotoFailure;
          message = downloadResult.error.toString();
          notifyListeners();
          return;
        }
        final uploadResult = await _repository.addPhotoToRegisteredUser(
          id,
          photoFile,
        );
        switch (uploadResult) {
          case Ok<RegisteredUserModel>():
            status = RegisteredUserCreateStatus.savePhotoSuccess;
          case Error<RegisteredUserModel>():
            status = RegisteredUserCreateStatus.savePhotoFailure;
            message = uploadResult.error.toString();
        }
      } on Exception catch (e) {
        status = RegisteredUserCreateStatus.savePhotoFailure;
        message = e.toString();
      }
      notifyListeners();
    }
  }

  Future<File> _tempImage(String type) async {
    final directory = await getTemporaryDirectory();
    return File('${directory.path}/$type.jpg');
  }

  void selectExpiredDate(List<DateTime?> expiredDates) {
    status = RegisteredUserCreateStatus.selectingExpiredDate;
    notifyListeners();
    if (expiredDates.isNotEmpty && expiredDates[0] != null) {
      status = RegisteredUserCreateStatus.selectExpiredDateSuccess;
      expiredDate = DateFormat('yyyy-MM-dd').format(expiredDates[0]!);
      notifyListeners();
    }
  }
}
