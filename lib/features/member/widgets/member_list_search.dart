import 'package:carpark/features/member/models/member_model.dart';
import 'package:carpark/shared/config/constants.dart';
import 'package:flutter/material.dart';

class MemberListSearch extends StatelessWidget {
  const MemberListSearch({
    required this.member,
    required this.onTap,
    super.key,
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
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Name',
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Status',
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                  ],
                ),
              ),
            )
          : Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        member.name!,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        member.status!,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16,
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
