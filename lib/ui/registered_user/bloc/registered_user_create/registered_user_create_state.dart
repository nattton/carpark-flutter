part of 'registered_user_create_bloc.dart';

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
  failure,
  selectingExpiredDate,
  selectExpiredDateSuccess,
}

final class RegisteredUserCreateState extends Equatable {
  final RegisteredUserCreateStatus status;
  final String message;
  final int id;
  final String idCard;
  final String engName;
  final String thaiName;
  final String birthdate;
  final String gender;
  final String address;
  final String photoUrl;
  final String telephone;
  final String type;
  final String expiredDate;
  const RegisteredUserCreateState({
    this.status = RegisteredUserCreateStatus.initial,
    this.message = "",
    this.id = 0,
    this.idCard = "",
    this.engName = "",
    this.thaiName = "",
    this.birthdate = "",
    this.gender = "",
    this.address = "",
    this.photoUrl = "",
    this.telephone = "",
    this.type = "",
    this.expiredDate = "",
  });

  @override
  List<Object> get props => [
    status,
    message,
    id,
    idCard,
    engName,
    thaiName,
    birthdate,
    gender,
    address,
    photoUrl,
    telephone,
    type,
    expiredDate,
  ];

  RegisteredUserCreateState copyWith({
    RegisteredUserCreateStatus? status,
    String? message,
    int? id,
    String? idCard,
    String? engName,
    String? thaiName,
    String? birthdate,
    String? gender,
    String? address,
    String? photoUrl,
    String? telephone,
    String? type,
    String? expiredDate,
    List<DateTime?>? expiredDates,
  }) {
    return RegisteredUserCreateState(
      status: status ?? this.status,
      message: message ?? this.message,
      id: id ?? this.id,
      idCard: idCard ?? this.idCard,
      engName: engName ?? this.engName,
      thaiName: thaiName ?? this.thaiName,
      birthdate: birthdate ?? this.birthdate,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      photoUrl: photoUrl ?? this.photoUrl,
      telephone: telephone ?? this.telephone,
      type: type ?? this.type,
      expiredDate: expiredDate ?? this.expiredDate,
    );
  }
}
