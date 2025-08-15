import 'package:carpark/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'id_card_entity.g.dart';

@JsonSerializable()
class IDCardEntity {
  final String id;
  final String engName;
  final String thaiName;
  final String birthdate;
  final String gender;
  final String address;
  final String photoPath;

  const IDCardEntity({
    required this.id,
    required this.engName,
    required this.thaiName,
    required this.birthdate,
    required this.gender,
    required this.address,
    required this.photoPath,
  });

  factory IDCardEntity.fromJson(Map<String, dynamic> json) =>
      _$IDCardEntityFromJson(json);

  Map<String, dynamic> toJson() => _$IDCardEntityToJson(this);

  String genderName() {
    if (kGenderMap.containsKey(gender)) {
      return kGenderMap[gender]!;
    }
    return gender;
  }

  String photoUrl() {
    return "$kSmartCardReaderUrl$photoPath";
  }
}
