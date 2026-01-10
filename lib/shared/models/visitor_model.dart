import 'package:carpark/features/member/models/member_model.dart';
import 'package:carpark/shared/config/app_config_provider.dart';
import 'package:carpark/shared/models/gate_log_model.dart';
import 'package:carpark/shared/models/null_time_model.dart';
import 'package:carpark/shared/models/visitor_image_model.dart';
import 'package:duration/duration.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visitor_model.g.dart';

@JsonSerializable()
class VisitorModel {
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
    this.photo,
    this.exitTime,
    this.visitorImages,
  });

  factory VisitorModel.empty() {
    return VisitorModel(0);
  }

  factory VisitorModel.fromJson(Map<String, dynamic> json) =>
      _$VisitorModelFromJson(json);
  int id;
  DateTime? createdAt;
  String? type;
  String? plateNumber;
  int? memberId;
  MemberModel? member;
  int? gateLogId;
  GateLogModel? gateLog;
  int? gateLogOutId;
  GateLogModel? gateLogOut;
  String? idCard;
  String? thaiName;
  String? engName;
  String? birthdate;
  String? gender;
  String? address;
  String? age;
  String? photo;
  NullTimeModel? exitTime;
  List<VisitorImageModel>? visitorImages;

  Map<String, dynamic> toJson() => _$VisitorModelToJson(this);

  String photoUrl() {
    if (photo != null && photo != '') {
      final currentHost = AppConfigProvider().getCurrentHost();
      return '$currentHost/anpr_store$photo';
    }
    return '';
  }

  String dateTimeFormat() {
    final dt = createdAt!.add(const Duration(hours: 7));
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dt);
  }

  String dateTimeNanoFormat() {
    final dt = createdAt!.add(const Duration(hours: 7));
    return DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(dt);
  }

  String dateTimeNanoShortFormat() {
    final dt = createdAt!.add(const Duration(hours: 7));
    return DateFormat('yyyyMMddHHmmss.SSS').format(dt);
  }

  String durationString() {
    if (exitTime == null || exitTime!.valid == false) {
      return '';
    }
    return exitTime!.time!.difference(createdAt!).pretty();
  }
}
