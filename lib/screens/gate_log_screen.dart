import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/components/gate_log_card.dart';
import 'package:carpark/components/gate_log_header_card.dart';
import 'package:carpark/constants.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/gate_log_result.dart';
import 'package:carpark/providers/gate_logs_notifier.dart';
import 'package:carpark/screens/visitor_detail_screen.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final gateLogsProvider =
    StateNotifierProvider<GateLogsNotifier, List<GateLogResult>>((ref) {
  return GateLogsNotifier();
});

final filterProvider = StateProvider((ref) => "");
final sortByProvider = StateProvider((ref) => "");

final filteredGateLogsProvider = Provider<List<GateLogResult>>((ref) {
  final filter = ref.watch(filterProvider);
  final sortBy = ref.watch(sortByProvider);
  final gateLogs = ref.watch(gateLogsProvider);

  List<GateLogResult> filterGateLogs = [];
  if (filter.isEmpty) {
    filterGateLogs = gateLogs;
  }
  if (filter.isEmpty) {
    filterGateLogs = gateLogs;
  }
  filterGateLogs = gateLogs.where((gateLog) {
    return gateLog.plateNumber.contains(filter) ||
        gateLog.memberName.contains(filter);
  }).toList();

  if (sortBy.isNotEmpty) {
    switch (sortBy) {
      case "date":
        filterGateLogs.sort((a, b) {
          return a.createdAt.compareTo(b.createdAt);
        });
        break;
      case "-date":
        filterGateLogs.sort((b, a) {
          return a.createdAt.compareTo(b.createdAt);
        });
        break;
      case "plateNumber":
        filterGateLogs.sort((a, b) {
          return a.plateNumber.compareTo(b.plateNumber);
        });
        break;
      case "-plateNumber":
        filterGateLogs.sort((b, a) {
          return a.plateNumber.compareTo(b.plateNumber);
        });
        break;
      case "memberName":
        filterGateLogs.sort((a, b) {
          return a.memberName.compareTo(b.memberName);
        });
        break;
      case "-memberName":
        filterGateLogs.sort((b, a) {
          return a.memberName.compareTo(b.memberName);
        });
        break;
      default:
    }
  }

  return filterGateLogs;
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
    _selectDate([DateTime(now.year, now.month, now.day)]);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void onSearchTextChanged(String text) async {
    ref.read(filterProvider.notifier).state = text;
  }

  void sortBy(String fieldName) {
    var sortBy = ref.read(sortByProvider.notifier);
    sortBy.state == fieldName
        ? sortBy.state = "-${sortBy.state}"
        : sortBy.state = fieldName;
  }

  Future<void> getGateLogList(List<DateTime?> selectedDate) async {
    EasyLoading.show(status: 'loading...');
    final gateLogs = ref.read(gateLogsProvider.notifier);
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
    final filteredGateLogs = ref.watch(filteredGateLogsProvider);
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
                child: Text(
                  _dates.length > 1
                      ? 'เลือกวันที่ : ${_dates[0]!.day}/${_dates[0]!.month}/${_dates[0]!.year} - ${_dates[1]!.day}/${_dates[1]!.month}/${_dates[1]!.year}'
                      : 'เลือกวันที่ : ${_dates[0]!.day}/${_dates[0]!.month}/${_dates[0]!.year}',
                  style: kButton2Style,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              OutlinedButton(
                onPressed: () {
                  _selectDate(_dates);
                },
                child: const Text(
                  'Refresh',
                  style: kButton2Style,
                ),
              ),
              Expanded(child: Container()),
              OutlinedButton(
                onPressed: () {
                  onPressedExportGateLog();
                },
                child: const Text(
                  'Export to Excel',
                  style: kButton2Style,
                ),
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
        GateLogHeaderCard(
          onTapDate: () {
            sortBy("date");
          },
          onTapPlateNumber: () {
            sortBy("plateNumber");
          },
          onTapMemberName: () {
            sortBy("memberName");
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredGateLogs.length,
            itemBuilder: (context, index) {
              return GateLogCard(
                  gateLog: filteredGateLogs[index],
                  onTap: () => viewDetail(filteredGateLogs[index]));
            },
          ),
        )
      ],
    );
  }

  void viewDetail(GateLogResult gateLog) {
    if (gateLog.visitorMemberId > 0) {
      Navigator.of(context)
          .pushNamed(VisitorDetailScreen.id, arguments: gateLog.visitorId);
    } else {
      Alert(
        context: context,
        title: "Gate Log",
        content: Column(
          children: <Widget>[
            Image.network(gateLog.captureImageUrl()),
          ],
        ),
      ).show();
    }
  }

  Excel generateExcel() {
    final gateLogs = ref.read(filteredGateLogsProvider);
    Excel excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    int currentRow = 0;
    List<CellValue> columnName = [
      TextCellValue("createdAt"),
      TextCellValue("gateName"),
      TextCellValue("anpr"),
      TextCellValue("plateNumber"),
      TextCellValue("member_name"),
      TextCellValue("visitor_member_name"),
      TextCellValue("captureImage"),
    ];
    sheetObject.insertRowIterables(columnName, currentRow);
    CellStyle cellStyle = CellStyle(
        backgroundColorHex: ExcelColor.fromHexString('#C4D9C3'), bold: true);
    for (var i = 0; i < columnName.length; i++) {
      var cell = sheetObject.cell(
          CellIndex.indexByColumnRow(columnIndex: i, rowIndex: currentRow));
      cell.cellStyle = cellStyle;
    }

    for (var i = 0; i < gateLogs.length; i++) {
      currentRow++;
      var m = gateLogs[i];
      List<CellValue> dataList = [
        TextCellValue(m.dateTimeFormat()),
        TextCellValue(m.gateName),
        TextCellValue(m.anpr),
        TextCellValue(m.plateNumber),
        TextCellValue(m.memberName),
        TextCellValue(m.visitorMemberName),
        TextCellValue(m.captureImageUrl()),
      ];
      sheetObject.insertRowIterables(dataList, currentRow, startingColumn: 0);
    }
    return excel;
  }

  void onPressedExportGateLog() async {
    String fileName = "gate_log";
    String date = DateFormat("_yyyy-MM-dd").format(_dates[0]!);
    fileName = "$fileName$date";

    if (_dates.length > 1) {
      String dateTo = DateFormat("_yyyy-MM-dd").format(_dates[1]!);
      fileName = "$fileName-$dateTo";
    }

    final filter = ref.read(filterProvider);
    if (filter.isNotEmpty) {
      fileName = "$fileName-$filter";
    }

    if (kIsWeb) {
      var excel = generateExcel();
      excel.save(fileName: '$fileName.xlsx');
    } else {
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Please select an output file:',
        fileName: '$fileName.xlsx',
      );

      if (outputFile != null) {
        final file = File(outputFile);
        file.writeAsBytes(generateExcel().encode()!);
      }
    }
  }
}
