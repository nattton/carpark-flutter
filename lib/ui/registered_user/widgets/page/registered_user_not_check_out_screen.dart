import 'package:carpark/domain/models/registered_user/registered_user_log.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/rounting/routes.dart';
import 'package:carpark/ui/registered_user/bloc/registered_user_not_check_out/registered_user_not_check_out_bloc.dart';
import 'package:carpark/ui/registered_user/widgets/registered_user_not_check_out_header_widget.dart';
import 'package:carpark/ui/registered_user/widgets/registered_user_not_check_out_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisteredUserNotCheckOutScreen extends StatefulWidget {
  const RegisteredUserNotCheckOutScreen({super.key});

  @override
  State<RegisteredUserNotCheckOutScreen> createState() =>
      _RegisteredUserNotCheckOutScreenState();

  static Widget get page => BlocProvider(
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
    return BlocBuilder<
      RegisteredUserNotCheckOutBloc,
      RegisteredUserNotCheckOutState
    >(
      builder: (context, state) {
        switch (state) {
          case RegisteredUserNotCheckOutLoading():
            return const Center(child: CircularProgressIndicator());
          case RegisteredUserNotCheckOutLoaded(:final registeredUserLog):
            return _buildRegisteredUserNotCheckOutList(registeredUserLog);
          case RegisteredUserNotCheckOutError(:final failure):
            return Center(child: Text(failure.message));
          default:
            return const Center(child: Text('Initial'));
        }
      },
    );
  }

  Widget _buildRegisteredUserNotCheckOutList(
    List<RegisteredUserLog> registeredUserLog,
  ) {
    return Column(
      children: [
        const RegisteredUserNotCheckOutHeaderWidget(),
        Expanded(
          child: ListView.builder(
            itemCount: registeredUserLog.length,
            itemBuilder: (context, index) {
              return RegisteredUserNotCheckOutRowWidget(
                log: registeredUserLog[index],
                onTap: () {
                  context.push(
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
