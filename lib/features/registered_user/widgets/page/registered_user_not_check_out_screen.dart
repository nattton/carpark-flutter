import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:carpark/features/registered_user/bloc/registered_user_not_check_out/registered_user_not_check_out_bloc.dart';
import 'package:carpark/features/registered_user/models/registered_user_log.dart';
import 'package:carpark/features/registered_user/widgets/registered_user_not_check_out_header_widget.dart';
import 'package:carpark/features/registered_user/widgets/registered_user_not_check_out_row_widget.dart';
import 'package:carpark/shared/injector/injector.dart';
import 'package:carpark/shared/rounting/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class RegisteredUserNotCheckOutScreen extends StatefulWidget {
  const RegisteredUserNotCheckOutScreen({super.key});

  @override
  State<RegisteredUserNotCheckOutScreen> createState() =>
      _RegisteredUserNotCheckOutScreenState();

  static Widget get page => BlocSignalProvider(
    create: (context) =>
        getIt<RegisteredUserNotCheckOutBloc>()
          ..add(GetRegisteredUserNotCheckOut()),
    child: const RegisteredUserNotCheckOutScreen(),
  );
}

class _RegisteredUserNotCheckOutScreenState
    extends State<RegisteredUserNotCheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocSignalBuilder<
      RegisteredUserNotCheckOutBloc,
      RegisteredUserNotCheckOutState
    >(
      builder: (context, state) {
        switch (state) {
          case RegisteredUserNotCheckOutLoading():
            return const Center(child: CircularProgressIndicator());
          case RegisteredUserNotCheckOutLoaded(:final registeredUserLog):
            return RegisteredUserNotCheckOutListWidget(
              registeredUserLog: registeredUserLog,
            );
          case RegisteredUserNotCheckOutError(:final failure):
            return Center(child: Text(failure.message));
          default:
            return const Center(child: Text('Initial'));
        }
      },
    );
  }
}

class RegisteredUserNotCheckOutListWidget extends StatelessWidget {
  const RegisteredUserNotCheckOutListWidget({
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
