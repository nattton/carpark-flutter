part of 'vehicles_bloc.dart';

@freezed
class VehiclesEvent with _$VehiclesEvent {
  const factory VehiclesEvent.started() = _Started;
  const factory VehiclesEvent.fetch(
          int offset, int limit, String term, String status, String isMember) =
      Fetch;
}
