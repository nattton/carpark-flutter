import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/config/constants.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/models/gate_log_result.dart';
import 'package:carpark/rounting/routes.dart';
import 'package:carpark/ui/gate_log/view_models/gate_log_viewmodel.dart';
import 'package:carpark/ui/gate_log/widgets/gate_log_card.dart';
import 'package:carpark/ui/gate_log/widgets/gate_log_header_card.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GateLogScreen extends WatchingStatefulWidget {
  const GateLogScreen({super.key});

  @override
  State<GateLogScreen> createState() => _GateLogScreenState();
}

class _GateLogScreenState extends State<GateLogScreen> {
  List<DateTime?> _dates = [DateTime.now()];

  final _searchController = TextEditingController();

  void _selectDate(List<DateTime?> newSelectedDate) {
    getIt<GateLogViewmodel>().getGateLogsCommand.run(newSelectedDate);
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectDate([DateTime(now.year, now.month, now.day)]);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void sortBy(String fieldName) {
    final sortBy = getIt<GateLogViewmodel>().sortBy.value;
    getIt<GateLogViewmodel>().sortBy.value = sortBy == fieldName
        ? '-$sortBy'
        : fieldName;
  }

  void alertError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final filteredGateLogs = watchValue(
      (GateLogViewmodel viewModel) => viewModel.filteredGateLogs,
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
              Expanded(child: Container()),
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
            controller: _searchController,
            autocorrect: false,
            onChanged: (value) =>
                getIt<GateLogViewmodel>().filter.value = value,
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: GestureDetector(
                onTap: () {
                  _searchController.clear();
                  getIt<GateLogViewmodel>().filter.value = '';
                },
                child: const Icon(Icons.clear),
              ),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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

  void viewDetail(GateLogResult gateLog) {
    if (gateLog.visitorMemberId > 0) {
      context.push(Routes.visitorWithId(gateLog.visitorId));
    } else {
      Alert(
        context: context,
        title: 'Gate Log',
        content: Column(
          children: <Widget>[Image.network(gateLog.captureImageUrl())],
        ),
      ).show();
    }
  }

  Excel generateExcel() {
    final gateLogs = getIt<GateLogViewmodel>().filteredGateLogs.value;
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

    final filter = getIt<GateLogViewmodel>().filter.value;

    if (filter.isNotEmpty) {
      fileName = '$fileName-$filter';
    }

    if (kIsWeb) {
      generateExcel().save(fileName: '$fileName.xlsx');
    } else {
      final outputFile = await FilePicker.platform.saveFile(
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
