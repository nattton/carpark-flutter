import 'package:json_annotation/json_annotation.dart';

part 'camera_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CameraModel {
  final int id;
  final String name;
  String ipAddress;
  String port;
  String username;
  String password;
  String path;

  CameraModel(
      {required this.id,
      required this.name,
      required this.ipAddress,
      required this.port,
      required this.username,
      required this.password,
      required this.path});

  factory CameraModel.fromJson(Map<String, dynamic> json) =>
      _$CameraModelFromJson(json);

  Map<String, dynamic> toJson() => _$CameraModelToJson(this);

  String toUrl() {
    return "rtsp://$username:$password@$ipAddress:$port$path";
  }
}
