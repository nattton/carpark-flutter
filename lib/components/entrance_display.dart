import 'package:carpark/models/gate_log_model.dart';
import 'package:flutter/material.dart';
import 'package:text_marquee/text_marquee.dart';

const double fontSize = 600;

class EntranceDisplay extends StatelessWidget {
  const EntranceDisplay({super.key, required this.gateLog});

  final GateLogModel gateLog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("ทางเข้า"),
          backgroundColor: Colors.blue[800],
        ),
        backgroundColor: Colors.blue,
        body: Container(
          width: double.infinity,
          color: Colors.blue[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              gateLog.memberId! == 0
                  ? const FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        "Visitor กรุณาลงทะเบียน",
                        style: TextStyle(fontSize: fontSize),
                      ))
                  : const FittedBox(
                      fit: BoxFit.fill,
                      child: TextMarquee(
                        "Welcome ยินดีต้อนรับ",
                        style: TextStyle(fontSize: fontSize),
                      )),
              FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    gateLog.plateNumber!,
                    style: const TextStyle(fontSize: fontSize),
                  )),
            ],
          ),
        ));
  }
}
