class LastGateLog {
  GateLog? gateIn;
  GateLog? gateOut;

  LastGateLog({this.gateIn, this.gateOut});

  LastGateLog.fromJson(Map<String, dynamic> json) {
    gateIn = json['gate_in'] != null ? GateLog.fromJson(json['gate_in']) : null;
    gateOut =
        json['gate_out'] != null ? GateLog.fromJson(json['gate_out']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (gateIn != null) {
      data['gate_in'] = gateIn!.toJson();
    }
    if (gateOut != null) {
      data['gate_out'] = gateOut!.toJson();
    }
    return data;
  }
}

class GateLog {
  int? id;
  String? createdAt;
  String? gateName;
  String? plateNumber;
  String? memberName;
  String? memberType;
  String? captureTime;
  String? captureImage;

  GateLog(
      {this.id,
      this.createdAt,
      this.gateName,
      this.plateNumber,
      this.memberName,
      this.memberType,
      this.captureTime,
      this.captureImage});

  GateLog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    gateName = json['gate_name'];
    plateNumber = json['plate_number'];
    memberName = json['member_name'];
    memberType = json['member_type'];
    captureTime = json['capture_time'];
    captureImage = json['capture_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['gate_name'] = gateName;
    data['plate_number'] = plateNumber;
    data['member_name'] = memberName;
    data['member_type'] = memberType;
    data['capture_time'] = captureTime;
    data['capture_image'] = captureImage;
    return data;
  }
}
