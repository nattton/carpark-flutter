// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carpark/models/gate_log_model.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/models/null_time_model.dart';
import 'package:carpark/models/visitor_image_model.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visitor_model.g.dart';

@JsonSerializable()
class VisitorModel {
  int id;
  DateTime? createdAt;
  String? type;
  String? plateNumber;
  int? memberId;
  MemberModel? member;
  int? gateLogId;
  GateLogModel? gateLog;
  String? idCard;
  String? thaiName;
  String? engName;
  String? birthdate;
  String? gender;
  String? address;
  String? age;
  NullTimeModel? exitTime;
  List<VisitorImageModel>? visitorImages;

  VisitorModel(
    this.id, {
    this.createdAt,
    this.type,
    this.plateNumber,
    this.memberId,
    this.member,
    this.gateLogId,
    this.gateLog,
    this.idCard,
    this.thaiName,
    this.engName,
    this.birthdate,
    this.gender,
    this.address,
    this.age,
    this.exitTime,
    this.visitorImages,
  });

  factory VisitorModel.empty() {
    return VisitorModel(0);
  }

  factory VisitorModel.fromJson(Map<String, dynamic> json) =>
      _$VisitorModelFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorModelToJson(this);

  String dateTimeFormat() {
    DateTime dt = createdAt!.add(const Duration(hours: 7));
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(dt);
  }

  String dateTimeNanoFormat() {
    DateTime dt = createdAt!.add(const Duration(hours: 7));
    return DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(dt);
  }

  String dateTimeNanoShortFormat() {
    DateTime dt = createdAt!.add(const Duration(hours: 7));
    return DateFormat("yyyyMMddHHmmss.SSS").format(dt);
  }

  String exitDateTimeFormat() {
    if (exitTime!.valid!) {
      DateTime dt = exitTime!.time!.add(const Duration(hours: 7));
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(dt);
    }
    return "";
  }
}
