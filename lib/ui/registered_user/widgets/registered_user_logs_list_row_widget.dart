import 'package:flutter/material.dart';

import '../../../config/constants.dart';
import '../../../domain/models/registered_user/registered_user_log.dart';

class RegisteredUserLogsRowWidget extends StatelessWidget {
  const RegisteredUserLogsRowWidget({
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
                  log.id.toString(),
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
              Expanded(
                child: Text(
                  log.checkOutTimeString,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  log.duration,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(width: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
