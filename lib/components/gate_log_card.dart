import 'package:carpark/constants.dart';
import 'package:carpark/models/gate_log_model.dart';
import 'package:flutter/material.dart';

class GateLogCard extends StatelessWidget {
  const GateLogCard({super.key, required this.gateLog, required this.onTap});

  final GateLogModel gateLog;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: gateLog.id == 0
          ? Card(
              color: Colors.blue.shade200,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "วันที่ เวลา",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "ประตู",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "เลขจากเครื่องอ่าน",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "ทะเบียน",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "ชื่อ",
                        style: TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        gateLog.dateTimeFormat(),
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        gateLog.gateName!,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        gateLog.anpr!,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        gateLog.plateNumber!,
                        style: const TextStyle(
                          fontFamily: kDefaultFont,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        gateLog.member!.name!,
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
