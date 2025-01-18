import 'package:carpark/features/registered_user/domain/entity/registered_user_log.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_not_check_out/registered_user_not_check_out_bloc.dart';
import 'package:carpark/features/registered_user/presentation/page/registered_user_logs_screen.dart';
import 'package:carpark/features/registered_user/presentation/widget/registered_user_not_check_out_header_widget.dart';
import 'package:carpark/features/registered_user/presentation/widget/registered_user_not_check_out_row_widget.dart';
import 'package:carpark/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisteredUserNotCheckOutScreen extends StatefulWidget {
  const RegisteredUserNotCheckOutScreen({super.key});

  @override
  State<RegisteredUserNotCheckOutScreen> createState() =>
      _RegisteredUserNotCheckOutScreenState();

  static const routeName = '/registered-user-not-check-out';

  static Widget get page => BlocProvider(
        create: (context) => getIt<RegisteredUserNotCheckOutBloc>()
          ..add(GetRegisteredUserNotCheckOut()),
        child: const RegisteredUserNotCheckOutScreen(),
      );
}

class _RegisteredUserNotCheckOutScreenState
    extends State<RegisteredUserNotCheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisteredUserNotCheckOutBloc,
        RegisteredUserNotCheckOutState>(
      builder: (context, state) {
        if (state is RegisteredUserNotCheckOutLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RegisteredUserNotCheckOutLoaded) {
          return _buildRegisteredUserNotCheckOutList(state.registeredUserLog);
        } else if (state is RegisteredUserNotCheckOutError) {
          return Center(child: Text(state.failure.message));
        }
        return const Center(child: Text('Initial'));
      },
    );
  }

  Widget _buildRegisteredUserNotCheckOutList(
      List<RegisteredUserLog> registeredUserLog) {
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
                        "${RegisteredUserLogsScreen.routeName}/${registeredUserLog[index].registeredUser!.id}");
                  });
            },
          ),
        ),
      ],
    );
  }
}
