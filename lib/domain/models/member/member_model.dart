import 'package:freezed_annotation/freezed_annotation.dart';

import 'vehicle_model.dart';

part 'member_model.freezed.dart';
part 'member_model.g.dart';

@freezed
abstract class MemberModel with _$MemberModel {
  const factory MemberModel({
    required int id,
    String? name,
    String? telephone,
    String? type,
    String? status,
    List<VehicleModel>? vehicles,
  }) = _MemberModel;

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  factory MemberModel.empty() => const MemberModel(id: 0);
}
