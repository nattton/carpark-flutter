import 'dart:async';
import 'dart:io';

import 'package:carpark/constants.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/checkout_model.dart';
import 'package:carpark/models/visitor_model.dart';
import 'package:carpark/screens/main_screen.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class ExitScreen extends StatefulHookConsumerWidget {
  const ExitScreen({super.key});

  @override
  ConsumerState<ExitScreen> createState() => _ExitScreenState();
}

class _ExitScreenState extends ConsumerState<ExitScreen> {
  final _barcodeController = TextEditingController();
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gateLog = ref.watch(lastGateProvider).gateOut;
    final player = ref.watch(cameraPlayerProvider);
    return gateLog.id != 0
        ? Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () => openGateOut(),
                      child: const Text(
                        "เปิดประตู ขาออก",
                        style: kButtonStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _barcodeController,
                      autofocus: true,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () => checkout(),
                          child: const Icon(Icons.barcode_reader),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0)),
                      ),
                      onSubmitted: (value) => checkout(),
                      focusNode: focusNode,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: gateLog.color(),
                          width: 4.0,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Table(
                            border: TableBorder.all(),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(),
                              1: FlexColumnWidth(),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
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
                                      children: <Widget>[
                                        Container(
                                          height: 40,
                                          color: Colors.red,
                                          child: const Center(
                                            child: Text(
                                              "Visitor",
                                              style: kGateStyle,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          color: Colors.red,
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
                                              "ชื่อ : ${gateLog.member!.name!}",
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
                                            child: Text(
                                              kOverdueText,
                                              style: kGateStyle,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          color: gateLog.color(),
                                          child: const Center(
                                              child: Text(
                                            kOverdue2Text,
                                            style: kGateStyle,
                                          )),
                                        ),
                                      ],
                                    )
                                  : TableRow(
                                      children: <Widget>[
                                        Container(),
                                        Container(),
                                      ],
                                    ),
                              TableRow(
                                children: <Widget>[
                                  Container(
                                    height: 70,
                                    color: Colors.amberAccent,
                                    child: Image.network(
                                        gateLog.licensePlateImageUrl()),
                                  ),
                                  Container(
                                    height: 70,
                                    color: Colors.amberAccent,
                                    child: Center(
                                      child: Text(
                                        gateLog.anpr!,
                                        style: kGateStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Image.network(gateLog.captureImageUrl()),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2 - 60,
                          maxHeight:
                              (MediaQuery.of(context).size.width / 2 - 60) /
                                  16 *
                                  9,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Video(
                          player: player.mainPlayer,
                          scale: 1.0, // default
                          showControls: false, // default
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2 - 60,
                          maxHeight:
                              (MediaQuery.of(context).size.width / 2 - 60) /
                                  16 *
                                  9,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Video(
                          player: player.sidePlayer,
                          scale: 1.0, // default
                          showControls: false, // default
                        ),
                      ),
                      gateLog.member?.status == 'overdue'
                          ? Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: gateLog.color(),
                                  width: 4.0,
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: const Text(
                                  kOverdueText,
                                  style: kOverdueTextStyle,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  void alertError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text('Alert Message'),
    //         content: Text(msg),
    //         actions: [
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: const Text('Close'))
    //         ],
    //       );
    //     });
  }

  Future<void> openGateOut() async {
    sl<ApiService>().openDoor(sl<AppService>().token, "out");
  }

  Future<File> _tempImage(String type) async {
    final directory = await getTemporaryDirectory();

    return File('${directory.path}/$type.jpg');
  }

  void addImageToVisitor(VisitorModel visitor) async {
    final cameraPlayer = ref.watch(cameraPlayerProvider);
    File inSideImage = await _tempImage("out_side");
    File entranceImage = await _tempImage("exit");
    cameraPlayer.sidePlayer.takeSnapshot(inSideImage, 640, 360);
    cameraPlayer.mainPlayer.takeSnapshot(entranceImage, 640, 360);
    await sl<ApiService>().addImageToVisitor(
        sl<AppService>().token, visitor.id, "out_side", inSideImage);
    await sl<ApiService>().addImageToVisitor(
        sl<AppService>().token, visitor.id, "exit", entranceImage);
  }

  void checkout() {
    if (_barcodeController.text.isNotEmpty) {
      final gateLog = ref.watch(lastGateProvider).gateOut;
      var barcode = _barcodeController.text;
      _barcodeController.clear();
      focusNode.requestFocus();
      sl<ApiService>()
          .checkoutVisitor(sl<AppService>().token,
              CheckoutModel(barcode: barcode, gateLogId: gateLog.id))
          .then((value) {
        alertError('ลงเวลาออก ทะเบียน : ${value.plateNumber}');
        addImageToVisitor(value);
        // openGateOut();
      }).onError((error, stackTrace) {
        alertError(error.toString());
      });
    }
  }
}
