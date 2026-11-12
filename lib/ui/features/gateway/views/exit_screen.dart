import 'dart:async';

import 'package:carpark/config/injector.dart';
import 'package:carpark/domain/models/registered_user.dart';
import 'package:carpark/routing/routes.dart';
import 'package:carpark/ui/features/gateway/view_models/exit_viewmodel.dart';
import 'package:carpark/ui/features/gateway/views/exit_card.dart';
import 'package:carpark/ui/features/home/view_models/last_gate_viewmodel.dart';
import 'package:carpark/ui/features/live_player/views/live_player_widget.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class ExitScreen extends WatchingStatefulWidget {
  const new({super.key});

  @override
  State<ExitScreen> createState() => _ExitScreenState();

  static Widget get page => const ExitScreen();
}

class _ExitScreenState extends State<ExitScreen> {
  late final ExitViewModel _viewModel;
  final _barcodeController = TextEditingController();
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<ExitViewModel>();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _barcodeController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gateLogOut = watchValue(
      (LastGateViewmodel viewModel) => viewModel.gateOut,
    );
    return gateLogOut.id != 0
        ? Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          controller: _barcodeController,
                          autofocus: true,
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: checkout,
                              child: const Icon(Icons.barcode_reader),
                            ),
                            contentPadding: const EdgeInsets.all(8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          onSubmitted: (value) => checkout(),
                          focusNode: focusNode,
                        ),
                      ),
                      const ExitCard(),
                    ],
                  ),
                ),
                const Expanded(
                  child: !kIsWeb ? LivePlayerWidget() : SizedBox(),
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
    showDialog<Widget>(
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

  Future<void> checkout() async {
    if (_barcodeController.text.isNotEmpty) {
      final barcode = _barcodeController.text;
      _barcodeController.clear();
      focusNode.requestFocus();
      final result = await _viewModel.checkout(barcode);
      switch (result) {
        case Ok<ExitCheckoutOutcome>():
          switch (result.value) {
            case ExitRegisteredUserCheckout(:final registeredUser):
              alertCheckOut(registeredUser);
            case ExitVisitorCheckout(:final visitor):
              alertMessage('ลงเวลาออก ทะเบียน : ${visitor.plateNumber}');
          }
        case Error<ExitCheckoutOutcome>():
          alertError(result.error.toString());
      }
    }
  }

  void alertCheckOut(RegisteredUser registeredUser) {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Check Out'),
          content: Text('ลงเวลาออกโดย ${registeredUser.thaiName}'),
          actions: [
            TextButton(
              onPressed: () async {
                context.pop();
                await context.push(
                  Routes.registeredUserLogsWithId(registeredUser.id),
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
