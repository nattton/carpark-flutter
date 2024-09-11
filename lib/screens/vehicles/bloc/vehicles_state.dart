part of 'vehicles_bloc.dart';

@freezed
class VehiclesState with _$VehiclesState {
  const factory VehiclesState.initial() = _Initial;
  const factory VehiclesState.success({
    required int offset,
    required List<VehicleModel> vehicles,
  }) = Success;

  const factory VehiclesState.endOfList() = EndOfList;
}
