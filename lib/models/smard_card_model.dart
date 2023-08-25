import 'package:carpark/constants.dart';
import 'package:carpark/models/id_card_model.dart';

class SmartCardModel {
  final String idCard;
  final String thaiName;
  final String engName;
  final String birthdate;
  final String gender;
  final String address;
  final String cardImage;

  SmartCardModel({
    required this.idCard,
    required this.thaiName,
    required this.engName,
    required this.birthdate,
    required this.gender,
    required this.address,
    required this.cardImage,
  });

  factory SmartCardModel.empty() {
    return SmartCardModel(
      idCard: "",
      thaiName: "",
      engName: "",
      birthdate: "",
      gender: "",
      address: "",
      cardImage: "",
    );
  }

  factory SmartCardModel.fromArray(dynamic data) {
    return SmartCardModel(
        idCard: data[0],
        thaiName: data[1],
        engName: data[2],
        birthdate: data[3],
        gender: data[4],
        address: data[5],
        cardImage: "");
  }

  factory SmartCardModel.fromIDCard(IDCardModel card) {
    var gender = card.gender;
    if (kGenderMap.containsKey(card.gender)) {
      gender = kGenderMap[card.gender]!;
    }
    return SmartCardModel(
        idCard: card.id,
        thaiName: card.thaiName,
        engName: card.engName,
        birthdate: card.birthdate,
        gender: gender,
        address: card.address,
        cardImage: "$kSmartCardReaderUrl/${card.photoPath}");
  }
}
