import 'package:carpark/injection_container.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/screens/member_screen.dart';
import 'package:carpark/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:carpark/components/member_list_card.dart';
import 'package:carpark/services/app_service.dart';

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({Key? key}) : super(key: key);

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  List<MemberModel> memberList = [];
  List<MemberModel> searchMemberList = [];

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getMember();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.search),
            title: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                  hintText: 'Search', border: InputBorder.none),
              onChanged: onSearchTextChanged,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                _searchController.clear();
                onSearchTextChanged('');
              },
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
    sl<ApiService>().getMemberList(sl<AppService>().token).then((value) {
      setState(() {
        memberList = value;
        searchMemberList = value;
      });
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
