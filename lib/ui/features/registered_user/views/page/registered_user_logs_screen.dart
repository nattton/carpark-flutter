import 'dart:async';
import 'dart:io';

import 'package:carpark/config/constants.dart';
import 'package:carpark/config/injector.dart';
import 'package:carpark/domain/models/registered_user.dart';
import 'package:carpark/domain/models/registered_user_log.dart';
import 'package:carpark/ui/features/registered_user/view_models/registered_user_logs_viewmodel.dart';
import 'package:carpark/ui/features/registered_user/views/registered_user_logs_list_header_widget.dart';
import 'package:carpark/ui/features/registered_user/views/registered_user_logs_list_row_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:material_ui/material_ui.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RegisteredUserLogsScreen extends StatefulWidget {
  const new({required this.userId, super.key});

  final int userId;

  @override
  State<RegisteredUserLogsScreen> createState() =>
      _RegisteredUserLogsScreenState();

  static Widget page({required int userId}) =>
      RegisteredUserLogsScreen(userId: userId);
}

class _RegisteredUserLogsScreenState extends State<RegisteredUserLogsScreen> {
  late final RegisteredUserLogsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<RegisteredUserLogsViewModel>();
    unawaited(_viewModel.getRegisteredUserLogs(widget.userId));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registered User Logs')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading ||
              (_viewModel.user == null && _viewModel.errorMessage == null)) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_viewModel.errorMessage != null) {
            return Center(child: Text(_viewModel.errorMessage!));
          }
          return _buildLogs(_viewModel.user!, _viewModel.logs);
        },
      ),
    );
  }

  List<Widget> _buildHeader(RegisteredUser user) {
    return [
      const Card(
        margin: EdgeInsets.only(left: 8, right: 8),
        color: Colors.blueGrey,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'ID Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'ชื่อภาษาไทย',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Eng Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Telephone',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(width: 24),
            ],
          ),
        ),
      ),
      Card(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 2),
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  user.idCard,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  user.thaiName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  user.engName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  user.telephone,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: kDefaultFont,
                    fontSize: 16,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final filename =
                      '${user.idCard}_${user.thaiName}_${user.engName}.png'
                          .replaceAll(' ', '_');

                  final outputFile = await FilePicker.saveFile(
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
                      await file.writeAsBytes(
                        buffer.asUint8List(
                          qrBytes.offsetInBytes,
                          qrBytes.lengthInBytes,
                        ),
                      );
                    }
                  }
                },
                child: const Icon(Icons.qr_code_scanner, size: 24),
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
