import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../config/constants.dart';
import '../../../../domain/models/registered_user/registered_user.dart';
import '../../../../domain/models/registered_user/registered_user_log.dart';
import '../../../../injector/injector.dart';
import '../../bloc/registered_user_logs/registered_user_logs_bloc.dart';
import '../registered_user_logs_list_header_widget.dart';
import '../registered_user_logs_list_row_widget.dart';

class RegisteredUserLogsScreen extends StatefulWidget {
  const RegisteredUserLogsScreen({super.key});

  @override
  State<RegisteredUserLogsScreen> createState() =>
      _RegisteredUserLogsScreenState();

  static Widget page({required int userId}) => BlocProvider(
    create: (context) =>
        getIt<RegisteredUserLogsBloc>()
          ..add(GetRegisteredUserLogs(userId: userId)),
    child: const RegisteredUserLogsScreen(),
  );
}

class _RegisteredUserLogsScreenState extends State<RegisteredUserLogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registered User Logs')),
      body: BlocBuilder<RegisteredUserLogsBloc, RegisteredUserLogsState>(
        builder: (context, state) {
          switch (state) {
            case RegisteredUserLogsInitial():
            case RegisteredUserLogsLoading():
              return const Center(child: CircularProgressIndicator());
            case RegisteredUserLogsSuccess(:final user, :final logs):
              return _buildLogs(user, logs);
            case RegisteredUserLogsFailure(:final message):
              return Center(child: Text(message));
          }
        },
      ),
    );
  }

  List<Widget> _buildHeader(RegisteredUser user) {
    return [
      Card(
        margin: const EdgeInsets.only(left: 8.0, right: 8.0),
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "ID Card",
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "ชื่อภาษาไทย",
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Eng Name",
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Telephone",
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(width: 24.0),
            ],
          ),
        ),
      ),
      Card(
        margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0),
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  user.idCard,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  user.thaiName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  user.engName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  user.telephone,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16.0,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final filename =
                      "${user.idCard}_${user.thaiName}_${user.engName}.png"
                          .replaceAll(" ", "_");

                  final outputFile = await FilePicker.platform.saveFile(
                    dialogTitle: 'Please select an output file:',
                    fileName: filename,
                  );

                  if (outputFile != null) {
                    final file = File(outputFile);
                    final qrBytes = await QrPainter(
                      data: user.generatedId,
                      version: QrVersions.auto,
                    ).toImageData(878);
                    if (qrBytes != null) {
                      final buffer = qrBytes.buffer;
                      file.writeAsBytes(
                        buffer.asUint8List(
                          qrBytes.offsetInBytes,
                          qrBytes.lengthInBytes,
                        ),
                      );
                    }
                  }
                },
                child: const Icon(Icons.qr_code_scanner, size: 24.0),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  Widget _buildLogs(RegisteredUser user, RegisteredUserLogList logs) {
    return Column(
      children: [
        ..._buildHeader(user),
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
