import 'package:equatable/equatable.dart';

typedef RegisteredUserLogList = List<RegisteredUserLog>;

class RegisteredUserLog extends Equatable {
  final int id;
  final String generatedId;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;

  const RegisteredUserLog(
      {this.id = 0,
      this.generatedId = "",
      this.checkInTime,
      this.checkOutTime});

  @override
  List<Object?> get props => [id, generatedId, checkInTime, checkOutTime];
}
