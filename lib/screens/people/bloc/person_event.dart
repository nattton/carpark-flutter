part of 'person_bloc.dart';

@freezed
class PersonEvent with _$PersonEvent {
  const factory PersonEvent.started() = _Started;
  const factory PersonEvent.get(String id) = Get;
  const factory PersonEvent.update(UpdatePersonModel updatePerson) = Update;
  const factory PersonEvent.edit(PersonModel person) = Edit;
  const factory PersonEvent.changeExpiresDate(PersonModel person) =
      ChangeExpiresDate;
}
