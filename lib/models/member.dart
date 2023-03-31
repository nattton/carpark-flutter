class Members {
  List<Member>? members;

  Members({this.members});

  Members.fromJson(Map<String, dynamic> json) {
    if (json['members'] != null) {
      members = <Member>[];
      json['members'].forEach((v) {
        members!.add(Member.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Member {
  int? id;
  String? name;
  String? telephone;
  String? type;
  String? status;
  List<Vehicle>? vehicles;

  Member(
      {this.id,
      this.name,
      this.telephone,
      this.type,
      this.status,
      this.vehicles});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    telephone = json['telephone'];
    type = json['type'];
    status = json['status'];
    if (json['vehicles'] != null) {
      vehicles = <Vehicle>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(Vehicle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['telephone'] = telephone;
    data['type'] = type;
    data['status'] = status;
    if (vehicles != null) {
      data['vehicles'] = vehicles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vehicle {
  int? id;
  int? memberId;
  String? plateNumber;
  String? plateProvince;
  String? brand;
  String? color;
  String? telephone;

  Vehicle(
      {this.id,
      this.memberId,
      this.plateNumber,
      this.plateProvince,
      this.brand,
      this.color,
      this.telephone});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    plateNumber = json['plate_number'];
    plateProvince = json['plate_province'];
    brand = json['brand'];
    color = json['color'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['member_id'] = memberId;
    data['plate_number'] = plateNumber;
    data['plate_province'] = plateProvince;
    data['brand'] = brand;
    data['color'] = color;
    data['telephone'] = telephone;
    return data;
  }
}
