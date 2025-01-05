import 'package:carpark/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'id_card_response.g.dart';

@JsonSerializable()
class IDCardResponse {
  final String id;
  final String engName;
  final String thaiName;
  final String birthdate;
  final String gender;
  final String address;
  final String photoPath;
  final String photoByte;

  const IDCardResponse(
      {required this.id,
      required this.engName,
      required this.thaiName,
      required this.birthdate,
      required this.gender,
      required this.address,
      required this.photoPath,
      required this.photoByte});

  factory IDCardResponse.fromJson(Map<String, dynamic> json) =>
      _$IDCardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IDCardResponseToJson(this);

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
