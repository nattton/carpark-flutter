import 'package:carpark/constants.dart';
import 'package:flutter/material.dart';

class VisitorHeaderCard extends StatelessWidget {
  const VisitorHeaderCard({
    super.key,
    required this.selectedColumn,
    required this.onTapDate,
    required this.onTapExitTime,
    required this.onTapPlateNumber,
    required this.onTapMemberName,
  });
  final int selectedColumn;
  final VoidCallback onTapDate;
  final VoidCallback onTapExitTime;
  final VoidCallback onTapPlateNumber;
  final VoidCallback onTapMemberName;

  TextStyle _columnStyle(int column) {
    if (selectedColumn == column) {
      return const TextStyle(
          fontFamily: kDefaultFont,
          fontSize: 22.0,
          fontWeight: FontWeight.w800);
    }
    return const TextStyle(
        fontFamily: kDefaultFont, fontSize: 16.0, fontWeight: FontWeight.bold);
  }

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
                onTap: (() {
                  onTapDate();
                }),
                child: Text(
                  "วันที่-เวลา เข้า",
                  style: _columnStyle(0),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onTapExitTime,
                child: Text(
                  "วันที่-เวลา ออก",
                  style: _columnStyle(1),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Text(
                  "ระยะเวลา",
                  style: _columnStyle(2),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onTapPlateNumber,
                child: Text(
                  "ทะเบียน",
                  style: _columnStyle(2),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onTapMemberName,
                child: Text(
                  "ติดต่อ",
                  style: _columnStyle(3),
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
