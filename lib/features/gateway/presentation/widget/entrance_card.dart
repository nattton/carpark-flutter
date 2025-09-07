import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpark/config/constants.dart';
import 'package:carpark/models/gate_log_model.dart';
import 'package:flutter/material.dart';

class EntranceCard extends StatelessWidget {
  const EntranceCard({
    required this.gateLog, required this.onTapSelectGateLog, super.key,
  });

  final GateLogModel gateLog;
  final VoidCallback onTapSelectGateLog;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: gateLog.color(), width: 4),
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
                        'วันที่: ${gateLog.dateFormat()}',
                        style: kGateStyle,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        'เวลา: ${gateLog.timeFormat()}',
                        style: kGateStyle,
                      ),
                    ),
                  ),
                ],
              ),
              if (gateLog.memberId! == 0) TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: Colors.red,
                          child: const Center(
                            child: Text('ผู้ติดต่อ', style: kGateStyle),
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
                                'สร้างผู้ติดต่อจากรถคันนี้',
                                style: kButtonStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ) else TableRow(
                      children: <Widget>[
                        Container(
                          height: 40,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              'ชื่อ : ${gateLog.member!.name}',
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
              if (gateLog.member?.status == 'overdue') TableRow(
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
                                'สร้างบัตรผู้ติดต่อ',
                                style: kButtonStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ) else TableRow(children: <Widget>[Container(), Container()]),
              TableRow(
                children: <Widget>[
                  Container(
                    height: 60,
                    color: Colors.amberAccent,
                    child: CachedNetworkImage(
                      imageUrl: gateLog.licensePlateImageUrl(),
                      errorWidget: (_, url, _) => Text('error loading : $url'),
                    ),
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
          const SizedBox(height: 10),
          CachedNetworkImage(
            imageUrl: gateLog.captureImageUrl(),
            errorWidget: (_, url, _) => Text('error loading : $url'),
          ),
        ],
      ),
    );
  }
}
