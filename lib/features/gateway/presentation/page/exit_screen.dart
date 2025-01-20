import 'dart:async';
import 'dart:io';

import 'package:carpark/constants.dart';
import 'package:carpark/features/gateway/presentation/widget/exit_card.dart';
import 'package:carpark/features/gateway/presentation/widget/live_player_section.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_check_out/registered_user_check_out_bloc.dart';
import 'package:carpark/features/registered_user/presentation/page/registered_user_logs_screen.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/models/checkout_model.dart';
import 'package:carpark/models/visitor_model.dart';
import 'package:carpark/screens/main_screen.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ExitScreen extends StatefulHookConsumerWidget {
  const ExitScreen({super.key});

  @override
  ConsumerState<ExitScreen> createState() => _ExitScreenState();

  static Widget get page => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => getIt<RegisteredUserCheckOutBloc>()),
        ],
        child: const ExitScreen(),
      );
}

class _ExitScreenState extends ConsumerState<ExitScreen> {
  late RegisteredUserCheckOutBloc _registeredUserCheckOutBloc;
  final _barcodeController = TextEditingController();
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    _registeredUserCheckOutBloc = context.read<RegisteredUserCheckOutBloc>();
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
    return BlocListener<RegisteredUserCheckOutBloc,
        RegisteredUserCheckOutState>(
      listener: (context, state) {
        if (state is RegisteredUserCheckOutSuccess) {
          alertMessage('ลงเวลาออก : ${state.registeredUser.thaiName}');
          context.push(
              "${RegisteredUserLogsScreen.routeName}/${state.registeredUser.id}");
        } else if (state is RegisteredUserCheckOutFailure) {
          alertError(state.failure.message);
        }
      },
      child: gateLog.id != 0
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
                        ? LivePlayerSection(
                            mainController: player.mainController,
                            sideController: player.sideController)
                        : const SizedBox(),
                  ),
                ],
              ),
            )
          : Container(),
    );
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
                    context.pop();
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  Future<void> openGateOut() async {
    await getIt<ApiService>().openDoor(getIt<AppService>().token, "out");
  }

  Future<File> _tempImage(String type) async {
    final directory = await getTemporaryDirectory();

    return File('${directory.path}/$type.jpg');
  }

  void addImageToVisitor(VisitorModel visitor) async {
    final cameraPlayer = ref.read(cameraPlayerProvider);
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
      await getIt<ApiService>().addImageToVisitor(
          getIt<AppService>().token, visitor.id, "out_side", outSideImage);
      outSideImage.delete();
    }
    if (await exitImage.exists()) {
      await getIt<ApiService>().addImageToVisitor(
          getIt<AppService>().token, visitor.id, "exit", exitImage);
      exitImage.delete();
    }
  }

  void checkout() {
    if (_barcodeController.text.isNotEmpty) {
      final gateLog = ref.watch(lastGateProvider).gateOut;
      var barcode = _barcodeController.text;
      _barcodeController.clear();
      focusNode.requestFocus();
      if (Uuid.isValidUUID(fromString: barcode)) {
        _registeredUserCheckOutBloc
            .add(PostRegisteredUserCheckOutEvent(generatedId: barcode));
      } else {
        getIt<ApiService>()
            .checkoutVisitor(getIt<AppService>().token,
                CheckoutModel(barcode: barcode, gateLogId: gateLog.id))
            .then((value) {
          alertMessage('ลงเวลาออก ทะเบียน : ${value.plateNumber}');
          addImageToVisitor(value);
        }).catchError((Object obj) {
          switch (obj.runtimeType) {
            case DioException:
              final res = (obj as DioException).response;
              if (res != null) {
                if (res.statusCode == HttpStatus.badRequest) {
                  alertError(
                      "ข้อมูลไม่ถูกต้อง หรือ ไม่ได้เปลี่ยนคีย์บอร์ดเป็นภาษาอังกฤษ");
                } else if (res.statusCode == HttpStatus.notFound) {
                  alertError("ไม่พบข้อมูล");
                }
              }
              break;
            default:
              break;
          }
        });
      }
    }
  }
}
