import 'package:flutter/material.dart';
import 'package:carpark/constants.dart';

class PeopleHeaderCard extends StatelessWidget {
  const PeopleHeaderCard({super.key});

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
                "ID Card",
                style: TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                "ชื่อไทย",
                style: TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                "Eng Name",
                style: TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
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
            SizedBox(width: 30.0),
          ],
        ),
      ),
    );
  }
}
