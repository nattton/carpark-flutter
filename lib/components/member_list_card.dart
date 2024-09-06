import 'package:carpark/constants.dart';
import 'package:carpark/models/member_model.dart';
import 'package:flutter/material.dart';

class MemberListCard extends StatelessWidget {
  const MemberListCard({super.key, required this.member, required this.onTap});

  final MemberModel member;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // List<String> plates = [];
    // if (member.vehicles != null) {
    //   for (var vehicle in member.vehicles!) {
    //     plates.add(vehicle.plateNumber!);
    //   }
    // }

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
                        "ID",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Name",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Tel",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Type",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Status",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Vehicles",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
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
                        member.id.toString(),
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        member.name,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        member.telephone,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        member.type,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        member.status,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        member.plateVehicles,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    const Icon(Icons.edit),
                  ],
                ),
              ),
            ),
    );
  }
}
