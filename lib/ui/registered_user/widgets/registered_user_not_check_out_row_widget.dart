import 'package:flutter/material.dart';

import '../../../config/constants.dart';
import '../../../domain/models/registered_user/registered_user_log.dart';

class RegisteredUserNotCheckOutRowWidget extends StatelessWidget {
  const RegisteredUserNotCheckOutRowWidget({
    super.key,
    required this.log,
    required this.onTap,
  });

  final RegisteredUserLog log;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  log.registeredUser!.thaiName,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  log.registeredUser!.engName,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  log.registeredUser!.telephone,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  log.checkInTimeString,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
