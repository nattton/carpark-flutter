import 'package:carpark/config/app_config_provider.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gate_log_result.g.dart';

@JsonSerializable()
class GateLogResult {
  const GateLogResult({
    required this.id,
    required this.createdAt,
    required this.gateName,
    required this.anpr,
    required this.plateNumber,
    required this.captureImage,
    required this.memberId,
    required this.memberName,
    required this.visitorId,
    required this.visitorMemberId,
    required this.visitorMemberName,
  });

  factory GateLogResult.fromJson(Map<String, dynamic> json) =>
      _$GateLogResultFromJson(json);
  final int id;
  final DateTime createdAt;
  final String gateName;
  final String anpr;
  final String plateNumber;
  final String captureImage;
  final String memberId;
  final String memberName;
  final int visitorId;
  final int visitorMemberId;
  final String visitorMemberName;

  Map<String, dynamic> toJson() => _$GateLogResultToJson(this);

  String captureImageUrl() {
    final currentHost = AppConfigProvider().getCurrentHost();
    return '$currentHost/anpr_store$captureImage';
  }

  String dateTimeFormat() {
    final dt = createdAt.add(const Duration(hours: 7));
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dt);
  }

  String dateTimeNanoFormat() {
    final dt = createdAt.add(const Duration(hours: 7));
    return DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(dt);
  }

  String dateFormat() {
    final dt = createdAt.add(const Duration(hours: 7));
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  String timeFormat() {
    final dt = createdAt.add(const Duration(hours: 7));
    return DateFormat('HH:mm:ss').format(dt);
  }
}
