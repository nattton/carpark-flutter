part of 'people_bloc.dart';

@freezed
class PeopleEvent with _$PeopleEvent {
  const factory PeopleEvent.started() = _Started;
  const factory PeopleEvent.fetch(
      int offset, int limit, String term, String type, String active) = Fetch;
}
