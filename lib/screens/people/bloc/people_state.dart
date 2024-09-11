part of 'people_bloc.dart';

@freezed
class PeopleState with _$PeopleState {
  const factory PeopleState.initial() = _Initial;
  const factory PeopleState.success({
    required int offset,
    required List<PersonModel> people,
  }) = Success;

  const factory PeopleState.endOfList() = EndOfList;
}
