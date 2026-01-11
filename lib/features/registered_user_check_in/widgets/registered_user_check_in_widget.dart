import 'package:carpark/features/registered_user/models/registered_user.dart';
import 'package:carpark/features/registered_user_check_in/registered_user_check_in.dart';
import 'package:carpark/shared/injector/injector.dart';
import 'package:carpark/shared/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/shared/rounting/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';

class RegisteredUserCheckInWidget extends WatchingWidget {
  const RegisteredUserCheckInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    pushScope(
      init: (di) => di.registerSingleton<RegisteredUserCheckInViewmodel>(
        RegisteredUserCheckInViewmodel(
          repository: getIt<RegisteredUserServiceRepository>(),
        ),
      ),
    );

    final barcodeController = createOnce(TextEditingController.new);
    final focusNode = createOnce(FocusNode.new);

    registerHandler(
      select: (RegisteredUserCheckInViewmodel viewModel) =>
          viewModel.checkInRegisteredUserCommand.errors,
      handler: (context, error, _) async {
        if (error != null) {
          await alertError(
            context,
            error.error.toString(),
          );
        }
      },
    );

    registerHandler(
      select: (RegisteredUserCheckInViewmodel viewModel) =>
          viewModel.checkInRegisteredUserCommand,
      handler: (context, registeredUser, _) async {
        if (registeredUser != null) {
          await alertCheckIn(context, registeredUser);
        }
      },
    );

    return TextField(
      controller: barcodeController,
      autofocus: true,
      autocorrect: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            getIt<RegisteredUserCheckInViewmodel>()
                .checkInRegisteredUserCommand(
                  barcodeController.text,
                );
            barcodeController.clear();
            focusNode.requestFocus();
          },
          child: const Icon(
            Icons.barcode_reader,
          ),
        ),
        contentPadding: const EdgeInsets.all(
          8,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            0,
          ),
        ),
      ),
      onSubmitted: (value) {
        getIt<RegisteredUserCheckInViewmodel>().checkInRegisteredUserCommand(
          barcodeController.text,
        );
        barcodeController.clear();
        focusNode.requestFocus();
      },
      focusNode: focusNode,
    );
  }

  Future<void> alertCheckIn(
    BuildContext context,
    RegisteredUser registeredUser,
  ) async {
    await showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Check In'),
          content: Text('ลงเวลาเข้าโดย ${registeredUser.thaiName}'),
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

  Future<void> alertError(BuildContext context, String msg) async {
    await showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Check In Error!'),
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
}
