import 'dart:async';

import 'package:carpark/config/injector.dart';
import 'package:carpark/domain/models/registered_user_log.dart';
import 'package:carpark/routing/routes.dart';
import 'package:carpark/ui/features/registered_user/view_models/registered_user_not_check_out_viewmodel.dart';
import 'package:carpark/ui/features/registered_user/views/registered_user_not_check_out_header_widget.dart';
import 'package:carpark/ui/features/registered_user/views/registered_user_not_check_out_row_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class RegisteredUserNotCheckOutScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<RegisteredUserNotCheckOutScreen> createState() =>
      _RegisteredUserNotCheckOutScreenState();

  static Widget get page => const RegisteredUserNotCheckOutScreen();
}

class _RegisteredUserNotCheckOutScreenState
    extends State<RegisteredUserNotCheckOutScreen> {
  late final RegisteredUserNotCheckOutViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<RegisteredUserNotCheckOutViewModel>();
    unawaited(_viewModel.getRegisteredUserNotCheckOut());
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        if (_viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_viewModel.errorMessage != null) {
          return Center(child: Text(_viewModel.errorMessage!));
        }
        return RegisteredUserNotCheckOutListWidget(
          registeredUserLog: _viewModel.registeredUserLogs,
        );
      },
    );
  }
}

class RegisteredUserNotCheckOutListWidget extends StatelessWidget {
  const new({
    required this.registeredUserLog,
    super.key,
  });

  final List<RegisteredUserLog> registeredUserLog;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RegisteredUserNotCheckOutHeaderWidget(),
        Expanded(
          child: ListView.builder(
            itemCount: registeredUserLog.length,
            itemBuilder: (context, index) {
              return RegisteredUserNotCheckOutRowWidget(
                log: registeredUserLog[index],
                onTap: () async {
                  await context.push(
                    Routes.registeredUserLogsWithId(
                      registeredUserLog[index].registeredUser!.id,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
