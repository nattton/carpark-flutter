class SmartCardModel {
  final String idCard;
  final String thaiName;
  final String engName;
  final String birthdate;
  final String gender;
  final String address;
  final String age;
  final String readDateTime;
  final String cardImage;

  SmartCardModel({
    required this.idCard,
    required this.thaiName,
    required this.engName,
    required this.birthdate,
    required this.gender,
    required this.address,
    required this.age,
    required this.readDateTime,
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
      age: "",
      readDateTime: "",
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
        age: data[6],
        readDateTime: data[7] + ' ' + data[8],
        cardImage: data[9]);
  }
}
