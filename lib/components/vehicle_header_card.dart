import 'package:flutter/material.dart';
import 'package:carpark/constants.dart';

class VehicleHeaderCard extends StatelessWidget {
  const VehicleHeaderCard({super.key});

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
                "เลขทะเบียน",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "เลขที่คล้าย",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "จังหวัด",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "ยี่ห้อ",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "สี",
                style: TextStyle(
                  fontFamily: kDefaultFont,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "โทร.",
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
