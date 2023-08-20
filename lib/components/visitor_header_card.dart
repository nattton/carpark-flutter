import 'package:flutter/material.dart';
import 'package:carpark/constants.dart';

class VisitorHeaderCard extends StatelessWidget {
  const VisitorHeaderCard(
      {super.key,
      required this.onTapDate,
      required this.onTapExitTime,
      required this.onTapPlateNumber,
      required this.onTapMemberName});
  final VoidCallback onTapDate;
  final VoidCallback onTapExitTime;
  final VoidCallback onTapPlateNumber;
  final VoidCallback onTapMemberName;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onTapDate,
                child: const Text(
                  "วันที่-เวลา เข้า",
                  style: TextStyle(
                      fontFamily: kDefaultFont,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onTapExitTime,
                child: const Text(
                  "วันที่-เวลา ออก",
                  style: TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onTapPlateNumber,
                child: const Text(
                  "ทะเบียน",
                  style: TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onTapMemberName,
                child: const Text(
                  "ติดต่อ",
                  style: TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Text(
                "ชื่อไทย",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
