import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_person_model.freezed.dart';
part 'update_person_model.g.dart';

@freezed
sealed class UpdatePersonModel with _$UpdatePersonModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory UpdatePersonModel({
    required String id,
    required String thaiName,
    required String engName,
    required String address,
    required String telephone,
    required String type,
    required bool isActive,
    required String expiresAt,
  }) = _UpdatePersonModel;

  factory UpdatePersonModel.fromJson(Map<String, dynamic> json) =>
      _$UpdatePersonModelFromJson(json);
}
