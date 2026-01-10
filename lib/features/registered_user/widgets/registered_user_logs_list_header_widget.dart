import 'package:carpark/shared/config/constants.dart';
import 'package:flutter/material.dart';

class RegisteredUserLogListHeaderWidget extends StatelessWidget {
  const RegisteredUserLogListHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade200,
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'ID',
                style: TextStyle(fontFamily: kDefaultFont, fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                'เวลาเข้า',
                style: TextStyle(fontFamily: kDefaultFont, fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                'เวลาออก',
                style: TextStyle(fontFamily: kDefaultFont, fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                'ระยะเวลา',
                style: TextStyle(fontFamily: kDefaultFont, fontSize: 16),
              ),
            ),
            SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}
