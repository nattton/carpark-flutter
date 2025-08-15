import 'package:carpark/constants.dart';
import 'package:carpark/models/gate_log_model.dart';
import 'package:flutter/material.dart';

class EntranceCard extends StatelessWidget {
  const EntranceCard({
    super.key,
    required this.gateLog,
    required this.onTapSelectGateLog,
  });

  final GateLogModel gateLog;
  final VoidCallback onTapSelectGateLog;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: gateLog.color(), width: 4.0),
      ),
      child: Column(
        children: [
          Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  Container(
                    height: 40,
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        "วันที่: ${gateLog.dateFormat()}",
                        style: kGateStyle,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        "เวลา: ${gateLog.timeFormat()}",
                        style: kGateStyle,
                      ),
                    ),
                  ),
                ],
              ),
              gateLog.memberId! == 0
                  ? TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: Colors.red,
                          child: const Center(
                            child: Text("ผู้ติดต่อ", style: kGateStyle),
                          ),
                        ),
                        Container(
                          height: 50,
                          color: Colors.red,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: onTapSelectGateLog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kColorButtonPrimary,
                              ),
                              child: const Text(
                                "สร้างผู้ติดต่อจากรถคันนี้",
                                style: kButtonStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : TableRow(
                      children: <Widget>[
                        Container(
                          height: 40,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              "ชื่อ : ${gateLog.member!.name}",
                              style: kGateStyle,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              gateLog.plateNumber!,
                              style: kGateStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
              gateLog.member?.status == 'overdue'
                  ? TableRow(
                      children: <Widget>[
                        Container(
                          height: 40,
                          color: gateLog.color(),
                          child: const Center(
                            child: Text(kOverdueText, style: kGateStyle),
                          ),
                        ),
                        Container(
                          height: 40,
                          color: gateLog.color(),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: onTapSelectGateLog,
                              child: const Text(
                                "สร้างบัตรผู้ติดต่อ",
                                style: kButtonStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : TableRow(children: <Widget>[Container(), Container()]),
              TableRow(
                children: <Widget>[
                  Container(
                    height: 60,
                    color: Colors.amberAccent,
                    child: Image.network(gateLog.licensePlateImageUrl()),
                  ),
                  Container(
                    height: 60,
                    color: Colors.amberAccent,
                    child: Center(
                      child: Text(gateLog.anpr!, style: kGateStyle),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Image.network(gateLog.captureImageUrl()),
        ],
      ),
    );
  }
}
