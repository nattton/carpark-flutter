import 'package:carpark/injection_container.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/screens/main_screen.dart';
import 'package:carpark/screens/member_screen.dart';
import 'package:carpark/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:carpark/components/member_list_card.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MemberListScreen extends ConsumerStatefulWidget {
  const MemberListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends ConsumerState<MemberListScreen> {
  List<MemberModel> searchMemberList = [];

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
        Expanded(
          child: ListView.builder(
            itemCount: searchMemberList.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return MemberListCard(
                  member: MemberModel(id: 0),
                  onTap: () {},
                );
              }
              return MemberListCard(
                  member: searchMemberList[index - 1],
                  onTap: () =>
                      onPressedRow(context, searchMemberList[index - 1]));
            },
          ),
        )
      ],
    );
  }

  Future<void> getMember() async {
    EasyLoading.show(status: 'loading...');
    final memberList = ref.read(memberListProvider);
    sl<ApiService>().getMemberList(sl<AppService>().token).then((value) {
      setState(() {
        memberList.clear();
        memberList.addAll(value);
        searchMemberList = value;
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
    final memberList = ref.read(memberListProvider);
    if (text.isEmpty) {
      setState(() {
        searchMemberList = memberList;
      });
    } else {
      setState(() {
        searchMemberList = memberList.where((member) {
          return member.name!.contains(text) ||
              ((member.vehicles!
                      .indexWhere((e) => e.plateNumber!.contains(text))) >
                  -1);
        }).toList();
      });
    }
  }
}
