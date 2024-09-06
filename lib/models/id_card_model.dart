import 'package:carpark/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'id_card_model.freezed.dart';
part 'id_card_model.g.dart';

@freezed
sealed class IDCardModel with _$IDCardModel {
  const IDCardModel._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory IDCardModel({
    required String id,
    required String engName,
    required String thaiName,
    required String birthdate,
    required String gender,
    required String address,
    required String photoPath,
    required String photoByte,
  }) = _IDCardModel;

  factory IDCardModel.fromJson(Map<String, dynamic> json) =>
      _$IDCardModelFromJson(json);

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
