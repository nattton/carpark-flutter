part of 'smart_card_bloc.dart';

enum SmartCardStateX {
  initial,
  reading,
  success,
  failure,
}

final class SmartCardState extends Equatable {
  final SmartCardStateX state;
  final String id;
  final String engName;
  final String thaiName;
  final String birthdate;
  final String gender;
  final String address;
  final String photoPath;
  final String photoByte;
  const SmartCardState(
      {required this.state,
      required this.id,
      required this.engName,
      required this.thaiName,
      required this.birthdate,
      required this.gender,
      required this.address,
      required this.photoPath,
      required this.photoByte});

  @override
  List<Object> get props =>
      [id, engName, thaiName, birthdate, gender, address, photoPath, photoByte];
}
