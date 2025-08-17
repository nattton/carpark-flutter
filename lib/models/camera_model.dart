import 'package:json_annotation/json_annotation.dart';

part 'camera_model.g.dart';

@JsonSerializable()
class CameraModel {
  final int id;
  final String name;
  final String ipAddress;
  final String port;
  final String username;
  final String password;
  final String path;

  CameraModel({
    required this.id,
    required this.name,
    required this.ipAddress,
    required this.port,
    required this.username,
    required this.password,
    required this.path,
  });

  factory CameraModel.fromJson(Map<String, dynamic> json) =>
      _$CameraModelFromJson(json);

  Map<String, dynamic> toJson() => _$CameraModelToJson(this);

  CameraModel copyWith({
    int? id,
    String? name,
    String? ipAddress,
    String? port,
    String? username,
    String? password,
    String? path,
  }) => CameraModel(
    id: id ?? this.id,
    name: name ?? this.name,
    ipAddress: ipAddress ?? this.ipAddress,
    port: port ?? this.port,
    username: username ?? this.username,
    password: password ?? this.password,
    path: path ?? this.path,
  );

  String toUrl() {
    return "rtsp://$username:$password@$ipAddress:$port$path";
  }
}
