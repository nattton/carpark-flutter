import 'package:carpark/shared/config/app_config_provider.dart';
import 'package:carpark/shared/models/null_time_model.dart';
import 'package:equatable/equatable.dart';

class RegisteredUser extends Equatable {
  const RegisteredUser({
    this.id = 0,
    this.generatedId = '',
    this.type = '',
    this.telephone = '',
    this.idCard = '',
    this.thaiName = '',
    this.engName = '',
    this.birthdate = '',
    this.gender = '',
    this.address = '',
    this.photo = '',
    this.createdAt,
    this.updatedAt,
    this.expiredDate,
  });
  final int id;
  final String generatedId;
  final String type;
  final String telephone;
  final String idCard;
  final String thaiName;
  final String engName;
  final String birthdate;
  final String gender;
  final String address;
  final String photo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final NullTimeModel? expiredDate;

  @override
  List<Object?> get props => [
    id,
    generatedId,
    type,
    telephone,
    idCard,
    thaiName,
    engName,
    birthdate,
    gender,
    address,
    photo,
    createdAt,
    updatedAt,
    expiredDate,
  ];

  String photoUrl() {
    if (photo.isNotEmpty) {
      final currentHost = AppConfigProvider().getCurrentHost();
      return '$currentHost/anpr_store$photo';
    }
    return '';
  }

  RegisteredUser copyWith({
    int? id,
    String? generatedId,
    String? type,
    String? telephone,
    String? idCard,
    String? thaiName,
    String? engName,
    String? birthdate,
    String? gender,
    String? address,
    String? photo,
    NullTimeModel? expiredDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RegisteredUser(
      id: id ?? this.id,
      generatedId: generatedId ?? this.generatedId,
      type: type ?? this.type,
      telephone: telephone ?? this.telephone,
      idCard: idCard ?? this.idCard,
      thaiName: thaiName ?? this.thaiName,
      engName: engName ?? this.engName,
      birthdate: birthdate ?? this.birthdate,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      expiredDate: expiredDate ?? this.expiredDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
