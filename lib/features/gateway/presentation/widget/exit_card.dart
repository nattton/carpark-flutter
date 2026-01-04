import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpark/config/constants.dart';
import 'package:carpark/ui/home/view_models/late_gate_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';

class ExitCard extends WatchingWidget {
  const ExitCard({super.key});

  @override
  Widget build(BuildContext context) {
    final gateLogOut = watchValue(
      (LastGateViewmodel viewModel) => viewModel.gateOut,
    );
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: gateLogOut.color(), width: 4),
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
                        'วันที่: ${gateLogOut.dateFormat()}',
                        style: kGateStyle,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        'เวลา: ${gateLogOut.timeFormat()}',
                        style: kGateStyle,
                      ),
                    ),
                  ),
                ],
              ),
              if (gateLogOut.memberId! == 0)
                TableRow(
                  children: <Widget>[
                    Container(
                      height: 40,
                      color: Colors.red,
                      child: const Center(
                        child: Text('Visitor', style: kGateStyle),
                      ),
                    ),
                    Container(height: 40, color: Colors.red),
                  ],
                )
              else
                TableRow(
                  children: <Widget>[
                    Container(
                      height: 40,
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          'ชื่อ : ${gateLogOut.member!.name!}',
                          style: kGateStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          gateLogOut.plateNumber!,
                          style: kGateStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              if (gateLogOut.member?.status == 'overdue')
                TableRow(
                  children: <Widget>[
                    Container(
                      height: 40,
                      color: gateLogOut.color(),
                      child: const Center(
                        child: Text(kOverdueText, style: kGateStyle),
                      ),
                    ),
                    Container(
                      height: 40,
                      color: gateLogOut.color(),
                      child: const Center(
                        child: Text(kOverdue2Text, style: kGateStyle),
                      ),
                    ),
                  ],
                )
              else
                TableRow(children: <Widget>[Container(), Container()]),
              TableRow(
                children: <Widget>[
                  Container(
                    height: 60,
                    color: Colors.amberAccent,
                    child: CachedNetworkImage(
                      imageUrl: gateLogOut.licensePlateImageUrl(),
                      errorWidget: (_, url, _) => Text('error loading : $url'),
                    ),
                  ),
                  Container(
                    height: 60,
                    color: Colors.amberAccent,
                    child: Center(
                      child: Text(gateLogOut.anpr!, style: kGateStyle),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          CachedNetworkImage(
            imageUrl: gateLogOut.captureImageUrl(),
            errorWidget: (_, url, _) => Text('error loading : $url'),
          ),
        ],
      ),
    );
  }
}
