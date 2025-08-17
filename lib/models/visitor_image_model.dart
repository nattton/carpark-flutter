import 'package:json_annotation/json_annotation.dart';

import '../constants.dart';

part 'visitor_image_model.g.dart';

@JsonSerializable()
class VisitorImageModel {
  int id;
  String type;
  String image;

  VisitorImageModel({
    required this.id,
    required this.type,
    required this.image,
  });

  factory VisitorImageModel.fromJson(Map<String, dynamic> json) =>
      _$VisitorImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorImageModelToJson(this);

  String imageUrl() {
    return "$kCurrentHost/anpr_store$image";
  }
}
