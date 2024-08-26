part of 'member_bloc.dart';

@freezed
class MemberEvent with _$MemberEvent {
  const factory MemberEvent.started() = _Started;
  const factory MemberEvent.getMember(int id) = GetMember;
  const factory MemberEvent.createMember(MemberModel member) = CreateMember;
  const factory MemberEvent.updateMember(MemberModel member) = UpdateMember;
  const factory MemberEvent.createVehicle(VehicleModel vehicle) = CreateVehicle;
  const factory MemberEvent.updateVehicle(VehicleModel vehicle) = UpdateVehicle;
  const factory MemberEvent.deleteVehicle(VehicleModel vehicle) = DeleteVehicle;
}
