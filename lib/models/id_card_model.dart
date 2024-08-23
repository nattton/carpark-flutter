import 'package:carpark/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'id_card_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class IDCardModel {
  final String id;
  final String engName;
  final String thaiName;
  final String birthdate;
  final String gender;
  final String address;
  final String photoPath;
  final String photoByte;

  const IDCardModel(
      {required this.id,
      required this.engName,
      required this.thaiName,
      required this.birthdate,
      required this.gender,
      required this.address,
      required this.photoPath,
      required this.photoByte});

  factory IDCardModel.fromJson(Map<String, dynamic> json) =>
      _$IDCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$IDCardModelToJson(this);

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
