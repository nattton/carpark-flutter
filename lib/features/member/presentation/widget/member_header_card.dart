import 'package:flutter/material.dart';
import '../../../../constants.dart';

class MemberHeaderCard extends StatelessWidget {
  const MemberHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "ชื่อ",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "โทรศัพท์",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "ประเภท",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "สถานะ",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "ทะเบียน",
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
    );
  }
}
