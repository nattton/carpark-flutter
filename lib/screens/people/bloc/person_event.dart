part of 'person_bloc.dart';

@freezed
class PersonEvent with _$PersonEvent {
  const factory PersonEvent.started() = _Started;
  const factory PersonEvent.getPerson(String id) = GetPerson;
  const factory PersonEvent.updatePerson(UpdatePersonModel updatePerson) =
      UpdatePerson;
}
