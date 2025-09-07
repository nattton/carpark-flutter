import 'package:carpark/config/constants.dart';
import 'package:flutter/material.dart';

class RegisteredUserNotCheckOutHeaderWidget extends StatelessWidget {
  const RegisteredUserNotCheckOutHeaderWidget({super.key});

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
                'ชื่อภาษาไทย',
                style: TextStyle(fontFamily: kDefaultFont, fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                'ชื่อภาษาอังกฤษ',
                style: TextStyle(fontFamily: kDefaultFont, fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                'เบอร์โทรศัพท์',
                style: TextStyle(fontFamily: kDefaultFont, fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                'เวลาเข้า',
                style: TextStyle(fontFamily: kDefaultFont, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
