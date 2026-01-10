import 'package:carpark/features/registered_user/models/registered_user_log.dart';
import 'package:carpark/shared/config/constants.dart';
import 'package:flutter/material.dart';

class RegisteredUserLogsRowWidget extends StatelessWidget {
  const RegisteredUserLogsRowWidget({
    required this.log,
    required this.onTap,
    super.key,
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
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  log.id.toString(),
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  log.checkInTimeString,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  log.checkOutTimeString,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  log.duration,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 30),
            ],
          ),
        ),
      ),
    );
  }
}
