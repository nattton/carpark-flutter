import 'package:carpark/config/injector.dart';
import 'package:carpark/ui/features/member/view_models/member_list_viewmodel.dart';
import 'package:carpark/ui/features/member/views/member_list_card.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:material_ui/material_ui.dart';

class MemberListView extends WatchingWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final isRunning = watchValue(
      (MemberListViewModel viewModel) =>
          viewModel.getMemberListCommand.isRunning,
    );

    if (isRunning) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredMembers = watchValue(
      (MemberListViewModel viewModel) => viewModel.filteredMemberListCommand,
    );
    return ListView.builder(
      itemCount: filteredMembers.length,
      itemBuilder: (context, index) {
        return MemberListCard(
          member: filteredMembers[index],
          onTap: () {
            getIt<MemberListViewModel>().goMemberScreenCommand(
              filteredMembers[index].id,
            );
          },
        );
      },
    );
  }
}
