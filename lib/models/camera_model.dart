import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_model.freezed.dart';
part 'camera_model.g.dart';

@freezed
class CameraModel with _$CameraModel {
  const CameraModel._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CameraModel({
    @Default(0) int id,
    @Default("") String name,
    @Default("") String ipAddress,
    @Default("") String port,
    @Default("") String username,
    @Default("") String password,
    @Default("") String path,
    @Default("") String controlPort,
    @Default("") String controlGate,
  }) = _CameraModel;

  factory CameraModel.fromJson(Map<String, dynamic> json) =>
      _$CameraModelFromJson(json);

  String toUrl() {
    return "rtsp://$username:$password@$ipAddress:$port$path";
  }
}
