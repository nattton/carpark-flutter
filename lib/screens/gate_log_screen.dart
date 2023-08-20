import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/components/gate_log_card.dart';
import 'package:carpark/constants.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/gate_log_model.dart';
import 'package:carpark/providers/gate_logs_notifier.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final gateLogProvider =
    StateNotifierProvider<GateLogsNotifier, List<GateLogModel>>((ref) {
  return GateLogsNotifier();
});

final filterProvider = StateProvider((ref) => "");

final filteredGateLogProvider = Provider<List<GateLogModel>>((ref) {
  final filter = ref.watch(filterProvider);
  final gateLogs = ref.watch(gateLogProvider);

  if (filter.isEmpty) {
    return gateLogs;
  }
  return gateLogs.where((gateLog) {
    return gateLog.plateNumber!.contains(filter) ||
        gateLog.member!.name!.contains(filter);
  }).toList();
});

class GateLogScreen extends ConsumerStatefulWidget {
  const GateLogScreen({super.key});

  @override
  ConsumerState<GateLogScreen> createState() => _GateLogScreenState();
}

class _GateLogScreenState extends ConsumerState<GateLogScreen> {
  List<DateTime?> _dates = [DateTime.now()];

  final _searchController = TextEditingController();

  void _selectDate(List<DateTime?> newSelectedDate) {
    getGateLogList(newSelectedDate);
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _selectDate([
      DateTime(now.year, now.month, now.day),
    ]);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  onSearchTextChanged(String text) async {
    ref.read(filterProvider.notifier).state = text;
  }

  Future<void> getGateLogList(List<DateTime?> selectedDate) async {
    EasyLoading.show(status: 'loading...');
    final gateLogs = ref.read(gateLogProvider.notifier);
    if (selectedDate.isNotEmpty) {
      var date = DateFormat('yyyy-MM-dd').format(selectedDate[0]!);
      var dateTo = date;
      if (selectedDate.length > 1) {
        dateTo = DateFormat('yyyy-MM-dd').format(selectedDate[1]!);
      }
      sl<ApiService>()
          .searchGateLog(sl<AppService>().token, date, dateTo)
          .then((value) {
        EasyLoading.dismiss();
        gateLogs.setState(value);
      }).onError((error, stackTrace) {
        EasyLoading.dismiss();
        alertError(error.toString());
      });
    }
  }

  void alertError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final filteredGateLogs = ref.watch(filteredGateLogProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () async {
                  var results = await showCalendarDatePicker2Dialog(
                    context: context,
                    config: CalendarDatePicker2WithActionButtonsConfig(
                        calendarType: CalendarDatePicker2Type.range),
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
                child: Text(_dates.length > 1
                    ? 'เลือกวันที่ : ${_dates[0]!.day}/${_dates[0]!.month}/${_dates[0]!.year} - ${_dates[1]!.day}/${_dates[1]!.month}/${_dates[1]!.year}'
                    : 'เลือกวันที่ : ${_dates[0]!.day}/${_dates[0]!.month}/${_dates[0]!.year}'),
              ),
              const SizedBox(
                width: 10.0,
              ),
              OutlinedButton(
                onPressed: () {
                  _selectDate(_dates);
                },
                child: const Text('Refresh'),
              ),
              Expanded(child: Container()),
              OutlinedButton(
                onPressed: () {
                  onPressedExportGateLog();
                },
                child: const Text('Export to Excel'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            autofocus: false,
            autocorrect: false,
            onChanged: onSearchTextChanged,
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: GestureDetector(
                onTap: () {
                  _searchController.clear();
                  onSearchTextChanged('');
                },
                child: const Icon(Icons.clear),
              ),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredGateLogs.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return GateLogCard(
                  gateLog: GateLogModel(0),
                  onTap: () {},
                );
              }
              return GateLogCard(
                  gateLog: filteredGateLogs[index - 1],
                  onTap: () => viewDetail(filteredGateLogs[index - 1]));
            },
          ),
        )
      ],
    );
  }

  void viewDetail(GateLogModel gateLog) {
    Alert(
      context: context,
      title: "Gate Log",
      content: Column(
        children: <Widget>[
          Image.network("$kHostUrl/anpr_store/${gateLog.captureImage!}"),
        ],
      ),
    ).show();
  }

  Excel generateExcel() {
    final gateLogs = ref.read(filteredGateLogProvider);
    Excel excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    int currentRow = 0;
    List<String> columnName = [
      "captureTime",
      "gateName",
      "anpr",
      "plateNumber",
      "member.name",
      "captureImage",
    ];
    sheetObject.insertRowIterables(columnName, currentRow);
    CellStyle cellStyle = CellStyle(backgroundColorHex: '#C4D9C3', bold: true);
    for (var i = 0; i < columnName.length; i++) {
      var cell = sheetObject.cell(
          CellIndex.indexByColumnRow(columnIndex: i, rowIndex: currentRow));
      cell.cellStyle = cellStyle;
    }

    for (var i = 0; i < gateLogs.length; i++) {
      currentRow++;
      var m = gateLogs[i];
      List<String> dataList = [
        m.dateTimeFormat(),
        m.gateName!,
        m.anpr!,
        m.plateNumber!,
        m.member!.name!,
        m.captureImage!,
      ];
      sheetObject.insertRowIterables(dataList, currentRow, startingColumn: 0);
    }
    return excel;
  }

  void onPressedExportGateLog() async {
    String dateTime = DateFormat("yyyy-MM-dd").format(_dates[0]!);

    if (_dates.length > 1) {
      String dateTo = DateFormat("_yyyy-MM-dd").format(_dates[1]!);
      dateTime = "$dateTime-$dateTo";
    }

    final filter = ref.read(filterProvider);
    if (filter.isNotEmpty) {
      dateTime = "$dateTime-$filter";
    }

    if (kIsWeb) {
      var excel = generateExcel();
      excel.save(fileName: 'gate_log_$dateTime.xlsx');
    } else {
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Please select an output file:',
        fileName: 'gate_log_$dateTime.xlsx',
      );

      if (outputFile != null) {
        final file = File(outputFile);
        file.writeAsBytes(generateExcel().encode()!);
      }
    }
  }
}
