// ignore: depend_on_referenced_packages
import "dart:ui";
import "package:carpark/constants.dart";
import "package:carpark/models/member_model.dart";
import "package:intl/intl.dart";
import 'package:json_annotation/json_annotation.dart';
part 'gate_log_model.g.dart';

@JsonSerializable()
class GateLogModel {
  final int id;
  DateTime? createdAt;
  String? gateName;
  String? ipAddress;
  String? anpr;
  String? plateNumber;
  int? memberId;
  MemberModel? member;
  DateTime? captureTime;
  String? captureImage;
  String? licensePlateImage;

  GateLogModel(this.id,
      {this.createdAt,
      this.gateName,
      this.ipAddress,
      this.anpr,
      this.plateNumber,
      this.memberId,
      this.member,
      this.captureTime,
      this.captureImage,
      this.licensePlateImage});

  factory GateLogModel.fromJson(Map<String, dynamic> json) =>
      _$GateLogModelFromJson(json);

  Map<String, dynamic> toJson() => _$GateLogModelToJson(this);

  String dateTimeFormat() {
    DateTime dt = captureTime!.add(const Duration(hours: 7));
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(dt);
  }

  String dateFormat() {
    if (captureTime == null) return '';
    DateTime dt = captureTime!.add(const Duration(hours: 7));
    return DateFormat("dd/MM/yyyy").format(dt);
  }

  String timeFormat() {
    if (captureTime == null) return '';
    DateTime dt = captureTime!.add(const Duration(hours: 7));
    return DateFormat("HH:mm:ss").format(dt);
  }

  Color color() {
    if (member?.id == 0) {
      return kColorVisitor;
    } else if (member?.status == 'overdue') {
      return kColorOverdue;
    }
    return kColorResidents;
  }
}
