import 'package:carpark/features/member/models/member_model.dart';
import 'package:carpark/shared/repositories/member/member_repository.dart';
import 'package:carpark/shared/utils/result.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@singleton
class MemberListViewModel {
  MemberListViewModel({required MemberRepository memberRepository})
    : _memberRepository = memberRepository;
  final MemberRepository _memberRepository;
  final _log = Logger('MemberListViewModel');

  final Command<List<MemberModel>, List<MemberModel>> memberListCommand =
      Command.createSync<List<MemberModel>, List<MemberModel>>(
        initialValue: [],
        (newParam) => newParam,
      );

  final Command<List<MemberModel>, List<MemberModel>>
  filteredMemberListCommand =
      Command.createSync<List<MemberModel>, List<MemberModel>>(
        initialValue: [],
        (newParam) => newParam,
      );

  late final Command<void, void> getMemberListCommand =
      Command.createAsyncNoParamNoResult(
        () async {
          final result = await _memberRepository.getMemberList();
          switch (result) {
            case Ok<List<MemberModel>>():
              memberListCommand(result.value);
              filterUpdatedCommand();
            case Error<List<MemberModel>>():
              _log.warning('Get member list failed! ${result.error}');
              throw result.error;
          }
        },
      );

  late final Command<void, void> filterUpdatedCommand =
      Command.createSyncNoParamNoResult(
        () {
          final filter = filterChangedCommand.value;
          final filtered = (filter.isEmpty)
              ? memberListCommand.value
              : memberListCommand.value.where((member) {
                  return member.name!.contains(filter) ||
                      member.vehicles != null &&
                          member.vehicles!.any(
                            (vehicle) => vehicle.plateNumber!.contains(
                              filter,
                            ),
                          );
                }).toList();
          filteredMemberListCommand(filtered);
        },
      );

  late final Command<String, String> filterChangedCommand =
      Command.createSync<String, String>(
          initialValue: '',
          (s) => s,
        )
        ..debounce(
          const Duration(milliseconds: 500),
        ).listen((_, _) => filterUpdatedCommand());

  late final Command<int?, int> goMemberScreenCommand =
      Command.createSync<int?, int>(
        initialValue: 0,
        (newParam) => newParam ?? 0,
      );
}
