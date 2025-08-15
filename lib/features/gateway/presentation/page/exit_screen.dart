import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/services/api_service.dart';
import '../../../../injector/injector.dart';
import '../../../../models/checkout_model.dart';
import '../../../../models/visitor_model.dart';
import '../../../../screens/main_screen.dart';
import '../../../../services/app_service.dart';
import '../../../registered_user/domain/entity/registered_user.dart';
import '../../../registered_user/presentation/bloc/registered_user_check_out/registered_user_check_out_bloc.dart';
import '../../../registered_user/presentation/page/registered_user_logs_screen.dart';
import '../widget/exit_card.dart';
import '../widget/live_player_section.dart';

class ExitScreen extends StatefulHookConsumerWidget {
  const ExitScreen({super.key});

  @override
  ConsumerState<ExitScreen> createState() => _ExitScreenState();

  static Widget get page => MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => getIt<RegisteredUserCheckOutBloc>()),
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
    return BlocListener<
      RegisteredUserCheckOutBloc,
      RegisteredUserCheckOutState
    >(
      listener: (context, state) {
        if (state is RegisteredUserCheckOutSuccess) {
          alertCheckOut(state.registeredUser);
        } else if (state is RegisteredUserCheckOutFailure) {
          alertError(state.failure.message);
        }
      },
      child: gateLog.id != 0
          ? Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _barcodeController,
                            autofocus: true,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () => checkout(),
                                child: const Icon(Icons.barcode_reader),
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(
                                8.0,
                                8.0,
                                8.0,
                                8.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                            ),
                            onSubmitted: (value) => checkout(),
                            focusNode: focusNode,
                          ),
                        ),
                        ExitCard(gateLog: gateLog),
                      ],
                    ),
                  ),
                  Expanded(
                    child: !kIsWeb
                        ? LivePlayerSection(
                            mainController: player.mainController,
                            sideController: player.sideController,
                          )
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
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<File> _tempImage(String type) async {
    final directory = await getTemporaryDirectory();

    return File('${directory.path}/$type.jpg');
  }

  void addImageToVisitor(VisitorModel visitor) async {
    final cameraPlayer = ref.read(cameraPlayerProvider);
    final outSideImage = await _tempImage("out_side");
    final exitImage = await _tempImage("exit");

    final sideScreenshot = await cameraPlayer.sidePlayer
        .screenshot();
    final mainScreenshot = await cameraPlayer.mainPlayer
        .screenshot();

    if (sideScreenshot != null) {
      outSideImage.writeAsBytes(sideScreenshot);
    }
    if (mainScreenshot != null) {
      exitImage.writeAsBytes(mainScreenshot);
    }

    if (await outSideImage.exists()) {
      await getIt<ApiService>().addImageToVisitor(
        getIt<AppService>().token,
        visitor.id,
        "out_side",
        outSideImage,
      );
      outSideImage.delete();
    }
    if (await exitImage.exists()) {
      await getIt<ApiService>().addImageToVisitor(
        getIt<AppService>().token,
        visitor.id,
        "exit",
        exitImage,
      );
      exitImage.delete();
    }
  }

  void checkout() async {
    if (_barcodeController.text.isNotEmpty) {
      final gateLog = ref.watch(lastGateProvider).gateOut;
      final barcode = _barcodeController.text;
      _barcodeController.clear();
      focusNode.requestFocus();
      if (Uuid.isValidUUID(fromString: barcode)) {
        _registeredUserCheckOutBloc.add(
          PostRegisteredUserCheckOutEvent(generatedId: barcode),
        );
      } else {
        try {
          final visitor = await getIt<ApiService>().checkoutVisitor(
            getIt<AppService>().token,
            CheckoutModel(barcode: barcode, gateLogId: gateLog.id),
          );

          alertMessage('ลงเวลาออก ทะเบียน : ${visitor.plateNumber}');
          addImageToVisitor(visitor);
        } on DioException catch (e) {
          final res = e.response;
          if (res != null) {
            if (res.statusCode == HttpStatus.badRequest) {
              alertError(
                "ข้อมูลไม่ถูกต้อง หรือ ไม่ได้เปลี่ยนคีย์บอร์ดเป็นภาษาอังกฤษ",
              );
            } else if (res.statusCode == HttpStatus.notFound) {
              alertError("ไม่พบข้อมูล");
            }
          }
        } catch (e) {
          alertError(e.toString());
        }
      }
    }
  }

  void alertCheckOut(RegisteredUser registeredUser) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Check Out'),
          content: Text('ลงเวลาออกโดย ${registeredUser.thaiName}'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                context.push(
                  "${RegisteredUserLogsScreen.routeName}/${registeredUser.id}",
                );
              },
              child: const Text('ดูประวัติการเข้าใช้งาน'),
            ),
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('ปิด'),
            ),
          ],
        );
      },
    );
  }
}
