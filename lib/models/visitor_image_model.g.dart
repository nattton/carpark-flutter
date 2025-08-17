// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorImageModel _$VisitorImageModelFromJson(Map<String, dynamic> json) =>
    VisitorImageModel(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$VisitorImageModelToJson(VisitorImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'image': instance.image,
    };
