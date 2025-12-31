import 'package:carpark/data/repositories/member/member_repository.dart';
import 'package:carpark/domain/models/member/member_model.dart';
import 'package:carpark/domain/models/member/vehicle_model.dart';
import 'package:carpark/models/response_model.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@singleton
class MemberViewModel extends ChangeNotifier {
  MemberViewModel({required MemberRepository memberRepository})
    : _memberRepository = memberRepository {
    createMemberCommand = Command.createAsync<MemberModel, MemberModel>(
      initialValue: MemberModel.empty(),
      (params) async {
        final result = await _memberRepository.createMember(params);
        switch (result) {
          case Ok<MemberModel>():
            return result.value;
          case Error<MemberModel>():
            _log.warning('Create member failed! ${result.error}');
            throw result.error;
        }
      },
    );

    getMemberCommand = Command.createAsync<int, MemberModel>(
      initialValue: MemberModel.empty(),
      (params) async {
        if (params == 0) {
          return MemberModel.empty();
        }
        final result = await _memberRepository.getMember(params);
        switch (result) {
          case Ok<MemberModel>():
            member.value = result.value;
            return result.value;
          case Error<MemberModel>():
            _log.warning('Get member failed! ${result.error}');
            throw result.error;
        }
      },
    );

    updateMemberCommand =
        Command.createAsync<MemberModel, Result<ResponseModel>>(
          initialValue: const Result.ok(ResponseModel()),
          (params) async {
            final result = await _memberRepository.updateMember(params);
            if (result is Error<ResponseModel>) {
              _log.warning('Update member failed! ${result.error}');
            }
            return result;
          },
        );

    createVehicleCommand =
        Command.createAsync<VehicleModel, Result<ResponseModel>>(
          initialValue: const Result.ok(ResponseModel()),
          (params) async {
            final result = await _memberRepository.createVehicle(params);
            if (result is Error<ResponseModel>) {
              _log.warning('Create vehicle failed! ${result.error}');
            }
            return result;
          },
        );

    updateVehicleCommand = Command.createAsync(
      initialValue: const Result.ok(ResponseModel()),
      (params) async {
        final result = await _memberRepository.updateVehicle(params);
        if (result is Error<ResponseModel>) {
          _log.warning('Update vehicle failed! ${result.error}');
        }
        return result;
      },
    );

    deleteVehicleCommand = Command.createAsync(
      initialValue: const Result.ok(null),
      (
        vehicleId,
      ) async {
        final result = await _memberRepository.deleteVehicle(vehicleId);
        if (result is Error<ResponseModel>) {
          _log.warning('Delete vehicle failed! ${result.error}');
        }
        return result;
      },
    );
  }
  final MemberRepository _memberRepository;
  final _log = Logger('MemberViewModel');

  final member = ValueNotifier<MemberModel>(
    MemberModel.empty(),
  );
  late Command<MemberModel, MemberModel> createMemberCommand;
  late Command<int, MemberModel> getMemberCommand;
  late Command<MemberModel, Result<ResponseModel>> updateMemberCommand;
  late Command<VehicleModel, Result<ResponseModel>> createVehicleCommand;
  late Command<VehicleModel, Result<ResponseModel>> updateVehicleCommand;
  late Command<int, Result<void>> deleteVehicleCommand;
}
