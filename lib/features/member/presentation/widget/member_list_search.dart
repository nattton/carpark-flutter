import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../domain/models/member/member_model.dart';

class MemberListSearch extends StatelessWidget {
  const MemberListSearch({
    super.key,
    required this.member,
    required this.onTap,
  });

  final MemberModel member;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: member.id == 0
          ? Card(
              color: Colors.blue.shade200,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Name",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Status",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 30.0),
                  ],
                ),
              ),
            )
          : Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        member.name!,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        member.status!,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(Icons.read_more),
                  ],
                ),
              ),
            ),
    );
  }
}
