import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

typedef RegisteredUserLogList = List<RegisteredUserLog>;

const String dateFormat = "yyyy-MM-dd HH:mm:ss";

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

  String get duration => checkOutTime != null && checkInTime != null
      ? "${checkOutTime!.difference(checkInTime!).inMinutes} minutes"
      : "";

  String get checkInTimeString =>
      checkInTime != null ? DateFormat(dateFormat).format(checkInTime!) : "";
  String get checkOutTimeString =>
      checkOutTime != null ? DateFormat(dateFormat).format(checkOutTime!) : "";
}
