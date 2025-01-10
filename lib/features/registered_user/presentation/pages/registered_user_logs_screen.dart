import 'package:carpark/features/registered_user/domain/entity/registered_user.dart';
import 'package:carpark/features/registered_user/domain/entity/registered_user_log.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_logs/registered_user_logs_bloc.dart';
import 'package:carpark/features/registered_user/presentation/widget/registered_user_logs_list_header_widget.dart';
import 'package:carpark/features/registered_user/presentation/widget/registered_user_logs_list_row_widget.dart';
import 'package:carpark/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisteredUserLogsScreen extends StatefulWidget {
  const RegisteredUserLogsScreen({super.key});

  static const String routeName = '/registered-user-logs';

  @override
  State<RegisteredUserLogsScreen> createState() =>
      _RegisteredUserLogsScreenState();

  static Widget page({required int userId}) => BlocProvider(
        create: (context) => getIt<RegisteredUserLogsBloc>()
          ..add(GetRegisteredUserLogs(userId: userId)),
        child: const RegisteredUserLogsScreen(),
      );
}

class _RegisteredUserLogsScreenState extends State<RegisteredUserLogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registered User Logs'),
      ),
      body: BlocBuilder<RegisteredUserLogsBloc, RegisteredUserLogsState>(
        builder: (context, state) {
          switch (state) {
            case RegisteredUserLogsInitial():
            case RegisteredUserLogsLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RegisteredUserLogsSuccess():
              return _buildLogs(state.user, state.logs);
            case RegisteredUserLogsFailure():
              return Center(
                child: Text(state.message),
              );
          }
        },
      ),
    );
  }

  Widget _buildLogs(RegisteredUser user, RegisteredUserLogList logs) {
    return Column(
      children: [
        Card(
          color: Colors.blueAccent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Text(user.idCard)),
                Expanded(child: Text(user.thaiName)),
                Expanded(child: Text(user.engName)),
                Expanded(child: Text(user.telephone)),
              ],
            ),
          ),
        ),
        const RegisteredUserLogListHeaderWidget(),
        Expanded(
          child: ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              return RegisteredUserLogsRowWidget(
                log: logs[index],
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}
