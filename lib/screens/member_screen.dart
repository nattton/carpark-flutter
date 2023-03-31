import 'package:carpark/models/member.dart';
import 'package:carpark/screens/vehicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:carpark/components/member_list_card.dart';
import 'package:carpark/services/app_service.dart';

class MemberScreen extends StatefulWidget {
  const MemberScreen({Key? key}) : super(key: key);

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  late AppService appService;
  List<Member> memberList = [];
  List<Member> searchMemberList = [];

  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    AppService.getInstance().then((value) {
      appService = value;
      getMember();
    });
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
              controller: searchController,
              decoration: const InputDecoration(
                  hintText: 'Search', border: InputBorder.none),
              onChanged: onSearchTextChanged,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                searchController.clear();
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
                  member: Member(id: 0),
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
    appService.fetchMemberList().then((value) {
      setState(() {
        memberList = value;
        for (Member member in memberList) {
          searchMemberList.add(member);
        }
      });
    }).catchError((error) {});
  }

  void onPressedRow(BuildContext context, Member member) {
    Navigator.of(context).pushNamed(VehicleScreen.id, arguments: member);
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
    searchMemberList.clear();
    if (text.isEmpty) {
      for (Member member in memberList) {
        searchMemberList.add(member);
      }
      setState(() {});
      return;
    }

    for (Member member in memberList) {
      if (member.name!.contains(text)) {
        searchMemberList.add(member);
      } else if ((member.vehicles!
              .indexWhere((e) => e.plateNumber!.contains(text))) >
          -1) {
        searchMemberList.add(member);
      }
    }

    setState(() {});
  }
}
