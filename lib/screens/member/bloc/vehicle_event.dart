part of 'vehicle_bloc.dart';

@freezed
class VehicleEvent with _$VehicleEvent {
  const factory VehicleEvent.started() = _Started;
  const factory VehicleEvent.createVehicle(VehicleModel vehicle) =
      CreateVehicle;
  const factory VehicleEvent.updateVehicle(VehicleModel vehicle) =
      UpdateVehicle;
  const factory VehicleEvent.deleteVehicle(VehicleModel vehicle) =
      DeleteVehicle;
}
