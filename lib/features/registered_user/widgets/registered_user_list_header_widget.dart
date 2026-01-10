import 'package:carpark/shared/config/constants.dart';
import 'package:flutter/material.dart';

class RegisteredUserListHeaderWidget extends StatelessWidget {
  const RegisteredUserListHeaderWidget({super.key});

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
                'รหัสบัตรประชาชน',
                style: TextStyle(fontFamily: kDefaultFont, fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                'ชื่อภาษาไทย',
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
                'ประเภท',
                style: TextStyle(fontFamily: kDefaultFont, fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                'วันหมดอายุ',
                style: TextStyle(fontFamily: kDefaultFont, fontSize: 16),
              ),
            ),
            SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}
