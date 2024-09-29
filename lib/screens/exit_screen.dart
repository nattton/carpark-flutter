import 'dart:async';
import 'dart:io';

import 'package:carpark/components/exit_card.dart';
import 'package:carpark/components/live_player_section.dart';
import 'package:carpark/constants.dart';
import 'package:carpark/features/main/presention/cubit/player_cubit.dart';
import 'package:carpark/features/main/presention/pages/main_screen.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/checkout_model.dart';
import 'package:carpark/models/visitor_model.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';
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
    return gateLog.id != 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      !kIsWeb
                          ? ElevatedButton(
                              onPressed: () => openGateOut(),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kColorButtonPrimary),
                              child: const Text(
                                "เปิดประตู ขาออก",
                                style: kButtonStyle,
                              ),
                            )
                          : const SizedBox(),
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
                      ExitCard(gateLog: gateLog),
                    ],
                  ),
                ),
                Expanded(
                  child: !kIsWeb
                      ? BlocBuilder<PlayerCubit, PlayerState>(
                          builder: (context, player) {
                          return LivePlayerSection(
                              mainController:
                                  VideoController(player.mainPlayer),
                              sideController:
                                  VideoController(player.sidePlayer));
                        })
                      : const SizedBox(),
                ),
              ],
            ),
          )
        : Container();
  }

  void alertMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void alertError(String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error Message'),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  Future<void> openGateOut() async {
    sl<ApiService>().openDoor(sl<AppService>().token, "out");
  }

  Future<File> _tempImage(String type) async {
    final directory = await getTemporaryDirectory();

    return File('${directory.path}/$type.jpg');
  }

  void addImageToVisitor(VisitorModel visitor) async {
    final cameraPlayer = context.read<PlayerCubit>().state;
    File outSideImage = await _tempImage("out_side");
    File exitImage = await _tempImage("exit");

    final Uint8List? sideScreenshot =
        await cameraPlayer.sidePlayer.screenshot();
    final Uint8List? mainScreenshot =
        await cameraPlayer.mainPlayer.screenshot();

    if (sideScreenshot != null) {
      outSideImage.writeAsBytes(sideScreenshot);
    }
    if (mainScreenshot != null) {
      exitImage.writeAsBytes(mainScreenshot);
    }

    if (await outSideImage.exists()) {
      await sl<ApiService>().addImageToVisitor(
          sl<AppService>().token, visitor.id, "out_side", outSideImage);
      outSideImage.delete();
    }
    if (await exitImage.exists()) {
      await sl<ApiService>().addImageToVisitor(
          sl<AppService>().token, visitor.id, "exit", exitImage);
      exitImage.delete();
    }
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
        alertMessage('ลงเวลาออก ทะเบียน : ${value.plateNumber}');
        addImageToVisitor(value);
      }).catchError((Object obj) {
        final res = (obj as DioException).response;
        if (res != null) {
          if (res.statusCode == HttpStatus.badRequest) {
            alertError(
                "ข้อมูลไม่ถูกต้อง หรือ ไม่ได้เปลี่ยนคีย์บอร์ดเป็นภาษาอังกฤษ");
          } else if (res.statusCode == HttpStatus.notFound) {
            alertError("ไม่พบข้อมูล");
          }
        }
      });
    }
  }
}
