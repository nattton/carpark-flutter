import 'package:carpark/components/member_header_card.dart';
import 'package:carpark/components/member_list_card.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/screens/main/main_screen.dart';
import 'package:carpark/screens/member_screen.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final filterProvider = StateProvider((ref) => "");

final filteredMemberListProvider = Provider<List<MemberModel>>((ref) {
  final filter = ref.watch(filterProvider);
  final members = ref.watch(membersProvider);

  if (filter.isEmpty) {
    return members;
  }
  return members.where((member) {
    return member.name!.contains(filter) ||
        member.stringVehicles!.contains(filter);
  }).toList();
});

class MemberListScreen extends ConsumerStatefulWidget {
  const MemberListScreen({super.key});

  @override
  ConsumerState<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends ConsumerState<MemberListScreen> {
  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getMember();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredMemberList = ref.watch(filteredMemberListProvider);
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            autofocus: false,
            autocorrect: false,
            onChanged: onSearchTextChanged,
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: GestureDetector(
                onTap: () {
                  _searchController.clear();
                  onSearchTextChanged('');
                },
                child: const Icon(Icons.clear),
              ),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
        const MemberHeaderCard(),
        Expanded(
          child: ListView.builder(
            itemCount: filteredMemberList.length,
            itemBuilder: (context, index) {
              return MemberListCard(
                  member: filteredMemberList[index],
                  onTap: () =>
                      onPressedRow(context, filteredMemberList[index]));
            },
          ),
        )
      ],
    );
  }

  Future<void> getMember() async {
    EasyLoading.show(status: 'loading...');
    final memberList = ref.read(membersProvider.notifier);
    sl<ApiService>().getMemberList(sl<AppService>().token).then((members) {
      setState(() {
        memberList.setState(members);
      });
      EasyLoading.dismiss();
    }).catchError((error) {});
  }

  void onPressedRow(BuildContext context, MemberModel member) async {
    Navigator.of(context)
        .pushNamed(MemberScreen.id, arguments: member.id)
        .then((value) => {getMember()});
  }

  void alertError(String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert Message'),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  onSearchTextChanged(String text) async {
    ref.read(filterProvider.notifier).state = text;
  }
}
