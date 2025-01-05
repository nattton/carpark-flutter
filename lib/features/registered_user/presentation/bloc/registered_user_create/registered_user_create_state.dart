part of 'registered_user_create_bloc.dart';

enum RegisteredUserCreateStatus {
  initial,
  reading,
  readSuccess,
  readFailure,
  creating,
  createSuccess,
  createFailure,
  failure,
}

final class RegisteredUserCreateState extends Equatable {
  final RegisteredUserCreateStatus state;
  final String id;
  final String idCard;
  final String engName;
  final String thaiName;
  final String birthdate;
  final String gender;
  final String address;
  final String photoPath;
  final String telephone;
  final String type;
  final String expiredDate;
  const RegisteredUserCreateState(
      {required this.state,
      required this.id,
      required this.idCard,
      required this.engName,
      required this.thaiName,
      required this.birthdate,
      required this.gender,
      required this.address,
      required this.photoPath,
      required this.telephone,
      required this.type,
      required this.expiredDate});

  @override
  List<Object> get props => [
        idCard,
        engName,
        thaiName,
        birthdate,
        gender,
        address,
        photoPath,
        telephone,
        type,
        expiredDate
      ];

  RegisteredUserCreateState copyWith({
    RegisteredUserCreateStatus? state,
    String? id,
    String? idCard,
    String? engName,
    String? thaiName,
    String? birthdate,
    String? gender,
    String? address,
    String? photoPath,
    String? telephone,
    String? type,
    String? expiredDate,
  }) {
    return RegisteredUserCreateState(
      state: state ?? this.state,
      id: id ?? this.id,
      idCard: idCard ?? this.idCard,
      engName: engName ?? this.engName,
      thaiName: thaiName ?? this.thaiName,
      birthdate: birthdate ?? this.birthdate,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      photoPath: photoPath ?? this.photoPath,
      telephone: telephone ?? this.telephone,
      type: type ?? this.type,
      expiredDate: expiredDate ?? this.expiredDate,
    );
  }
}
