import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/config/constants.dart';
import 'package:carpark/config/injector.dart';
import 'package:carpark/domain/models/gate_log_result.dart';
import 'package:carpark/routing/routes.dart';
import 'package:carpark/ui/features/gate_log/view_models/gate_log_viewmodel.dart';
import 'package:carpark/ui/features/gate_log/views/gate_log_card.dart';
import 'package:carpark/ui/features/gate_log/views/gate_log_header_card.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

class GateLogScreen extends WatchingStatefulWidget {
  const new({super.key});

  @override
  State<GateLogScreen> createState() => _GateLogScreenState();
}

class _GateLogScreenState extends State<GateLogScreen> {
  List<DateTime?> _dates = [DateTime.now()];

  void _selectDate(List<DateTime?> newSelectedDate) {
    getIt<GateLogViewmodel>().getGateLogsCommand.run(newSelectedDate);
  }

  void sortBy(String fieldName) {
    getIt<GateLogViewmodel>().sortByChangedCommand(fieldName);
  }

  void alertError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final searchController = createOnce(TextEditingController.new);

    callOnce((_) {
      final now = DateTime.now();
      _selectDate([DateTime(now.year, now.month, now.day)]);
    });

    final isRunning = watchValue(
      (GateLogViewmodel viewModel) => viewModel.getGateLogsCommand.isRunning,
    );

    final filteredGateLogs = watchValue(
      (GateLogViewmodel viewModel) => viewModel.filteredGateLogsCommand,
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () async {
                  final results = await showCalendarDatePicker2Dialog(
                    context: context,
                    config: CalendarDatePicker2WithActionButtonsConfig(
                      calendarType: CalendarDatePicker2Type.range,
                    ),
                    dialogSize: const Size(325, 400),
                    value: _dates,
                    borderRadius: BorderRadius.circular(15),
                  );

                  if (results != null) {
                    setState(() {
                      _selectDate(results);
                      _dates = results;
                    });
                  }
                },
                child: Text(
                  _dates.length > 1
                      ? 'เลือกวันที่ : ${_dates[0]!.day}/${_dates[0]!.month}/${_dates[0]!.year} - ${_dates[1]!.day}/${_dates[1]!.month}/${_dates[1]!.year}'
                      : 'เลือกวันที่ : ${_dates[0]!.day}/${_dates[0]!.month}/${_dates[0]!.year}',
                  style: kButton2Style,
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {
                  _selectDate(_dates);
                },
                child: const Text('Refresh', style: kButton2Style),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: onPressedExportGateLog,
                child: const Text('Export to Excel', style: kButton2Style),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: searchController,
            autocorrect: false,
            onChanged: (value) =>
                getIt<GateLogViewmodel>().filterChangedCommand.run(value),
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: GestureDetector(
                onTap: () {
                  searchController.clear();
                  getIt<GateLogViewmodel>().filterChangedCommand.run('');
                },
                child: const Icon(Icons.clear),
              ),
              contentPadding: const EdgeInsets.all(20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        GateLogHeaderCard(
          onTapDate: () {
            sortBy('date');
          },
          onTapPlateNumber: () {
            sortBy('plateNumber');
          },
          onTapMemberName: () {
            sortBy('memberName');
          },
        ),
        if (isRunning)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else
          Expanded(
            child: ListView.builder(
              itemCount: filteredGateLogs.length,
              itemBuilder: (context, index) {
                return GateLogCard(
                  gateLog: filteredGateLogs[index],
                  onTap: () => viewDetail(filteredGateLogs[index]),
                );
              },
            ),
          ),
      ],
    );
  }

  Future<void> viewDetail(GateLogResult gateLog) async {
    if (gateLog.visitorMemberId > 0) {
      await context.push(Routes.visitorWithId(gateLog.visitorId));
    } else {
      final images = <String>[
        if (gateLog.captureImageUrl().isNotEmpty) gateLog.captureImageUrl(),
      ];

      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('${gateLog.gateName} - ${gateLog.plateNumber}'),
            content: SizedBox(
              width: 500,
              child: images.isEmpty
                  ? const SizedBox(
                      height: 120,
                      child: Center(
                        child: Icon(Icons.broken_image, size: 64, color: Colors.grey),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (final imageUrl in images)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  placeholder: (_, _) => const SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  errorWidget: (_, _, _) => Container(
                                    height: 200,
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 64,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('ปิด'),
              ),
            ],
          );
        },
      );
    }
  }

  Excel generateExcel() {
    final gateLogs = getIt<GateLogViewmodel>().filteredGateLogsCommand.value;
    final excel = Excel.createExcel();
    final sheetObject = excel['Sheet1'];

    var currentRow = 0;
    final columnName = <CellValue>[
      TextCellValue('createdAt'),
      TextCellValue('gateName'),
      TextCellValue('anpr'),
      TextCellValue('plateNumber'),
      TextCellValue('member_name'),
      TextCellValue('visitor_member_name'),
      TextCellValue('captureImage'),
    ];
    sheetObject.insertRowIterables(columnName, currentRow);
    final cellStyle = CellStyle(
      backgroundColorHex: ExcelColor.fromHexString('#C4D9C3'),
      bold: true,
    );
    for (var i = 0; i < columnName.length; i++) {
      sheetObject
              .cell(
                CellIndex.indexByColumnRow(
                  columnIndex: i,
                  rowIndex: currentRow,
                ),
              )
              .cellStyle =
          cellStyle;
    }

    for (var i = 0; i < gateLogs.length; i++) {
      currentRow++;
      final m = gateLogs[i];
      final dataList = <CellValue>[
        TextCellValue(m.dateTimeFormat()),
        TextCellValue(m.gateName),
        TextCellValue(m.anpr),
        TextCellValue(m.plateNumber),
        TextCellValue(m.memberName),
        TextCellValue(m.visitorMemberName),
        TextCellValue(m.captureImageUrl()),
      ];
      sheetObject.insertRowIterables(dataList, currentRow);
    }
    return excel;
  }

  Future<void> onPressedExportGateLog() async {
    var fileName = 'gate_log';
    final date = DateFormat('_yyyy-MM-dd').format(_dates[0]!);
    fileName = '$fileName$date';

    if (_dates.length > 1) {
      final dateTo = DateFormat('_yyyy-MM-dd').format(_dates[1]!);
      fileName = '$fileName-$dateTo';
    }

    final filter = getIt<GateLogViewmodel>().filterChangedCommand.value;

    if (filter.isNotEmpty) {
      fileName = '$fileName-$filter';
    }

    if (kIsWeb) {
      generateExcel().save(fileName: '$fileName.xlsx');
    } else {
      final outputFile = await FilePicker.saveFile(
        dialogTitle: 'Please select an output file:',
        fileName: '$fileName.xlsx',
      );

      if (outputFile != null) {
        final file = File(outputFile);
        await file.writeAsBytes(generateExcel().encode()!);
      }
    }
  }
}
