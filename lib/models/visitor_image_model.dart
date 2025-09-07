import 'package:carpark/config/app_config_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visitor_image_model.g.dart';

@JsonSerializable()
class VisitorImageModel {
  VisitorImageModel({
    required this.id,
    required this.type,
    required this.image,
  });

  factory VisitorImageModel.fromJson(Map<String, dynamic> json) =>
      _$VisitorImageModelFromJson(json);
  int id;
  String type;
  String image;

  Map<String, dynamic> toJson() => _$VisitorImageModelToJson(this);

  String imageUrl() {
    final currentHost = AppConfigProvider().getCurrentHost();
    return '$currentHost/anpr_store$image';
  }
}
