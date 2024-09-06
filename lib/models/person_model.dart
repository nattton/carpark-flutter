import 'package:carpark/models/visitor_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_model.freezed.dart';
part 'person_model.g.dart';

@unfreezed
class PersonModel with _$PersonModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory PersonModel({
    @Default("") String id,
    @Default("") String idCard,
    @Default("") String thaiName,
    @Default("") String engName,
    @Default("") String birthdate,
    @Default("") String gender,
    @Default("") String address,
    @Default("") String photo,
    @Default("") String status,
    @Default("") String updatedAt,
    @Default([]) List<VisitorModel>? visitors,
    String? expiresAt,
  }) = _PersonModel;

  factory PersonModel.fromJson(Map<String, dynamic> json) =>
      _$PersonModelFromJson(json);
}
