part of 'person_bloc.dart';

@freezed
class PersonState with _$PersonState {
  const factory PersonState.initial() = _Initial;
  const factory PersonState.success({
    required PersonModel person,
  }) = Success;
  const factory PersonState.error({
    required String message,
  }) = Error;
  const factory PersonState.updateSuccess() = UpdateSuccess;
}
