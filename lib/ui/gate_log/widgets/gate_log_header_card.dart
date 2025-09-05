import 'package:flutter/material.dart';

import '../../../config/constants.dart';

class GateLogHeaderCard extends StatelessWidget {
  const GateLogHeaderCard({
    super.key,
    required this.onTapDate,
    required this.onTapPlateNumber,
    required this.onTapMemberName,
  });
  final VoidCallback onTapDate;
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
                  "วันที่ เวลา",
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
                "ประตู",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onTapPlateNumber,
                child: const Text(
                  "เลขจากเครื่องอ่าน",
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
                  "ชื่อสมาชิก",
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
          ],
        ),
      ),
    );
  }
}
