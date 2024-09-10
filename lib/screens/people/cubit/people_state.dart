part of 'people_cubit.dart';

@freezed
class PeopleState with _$PeopleState {
  const factory PeopleState({
    @Default([]) List<PersonModel> people,
    @Default([]) List<PersonModel> filteredPeople,
  }) = _PeopleState;
}
