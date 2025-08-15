import 'package:carpark/constants.dart';
import 'package:carpark/models/visitor_model.dart';
import 'package:flutter/material.dart';

class VisitorListCard extends StatelessWidget {
  const VisitorListCard({
    super.key,
    required this.visitor,
    required this.onTap,
  });

  final VisitorModel visitor;
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
                  visitor.dateTimeNanoFormat(),
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  visitor.exitTime!.toDateTimeNanoString(),
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  visitor.durationString(),
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  visitor.plateNumber!,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  visitor.member!.name!,
                  style: const TextStyle(
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  visitor.thaiName!,
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
