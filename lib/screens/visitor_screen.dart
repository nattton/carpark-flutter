import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/components/visitor_header_card.dart';
import 'package:carpark/components/visitor_list_card.dart';
import 'package:carpark/constants.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/models/visitor_model.dart';
import 'package:carpark/providers/visitors_notifier.dart';
import 'package:carpark/screens/visitor_detail_screen.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final visitorsProvider =
    StateNotifierProvider<VisitorsNotifier, List<VisitorModel>>((ref) {
  return VisitorsNotifier();
});

final filterProvider = StateProvider((ref) => "");
final sortByProvider = StateProvider((ref) => "");

final filteredVisitorsProvider = Provider<List<VisitorModel>>((ref) {
  final filter = ref.watch(filterProvider);
  final sortBy = ref.watch(sortByProvider);
  final visitors = ref.watch(visitorsProvider);
  List<VisitorModel> filterVisitor = [];
  if (filter.isEmpty) {
    filterVisitor = visitors;
  }
  filterVisitor = visitors.where((visitor) {
    return visitor.plateNumber!.contains(filter) ||
        visitor.member!.name!.contains(filter);
  }).toList();

  if (sortBy.isNotEmpty) {
    switch (sortBy) {
      case "date":
        filterVisitor.sort((a, b) {
          return a.createdAt!.compareTo(b.createdAt!);
        });
        break;
      case "-date":
        filterVisitor.sort((b, a) {
          return a.createdAt!.compareTo(b.createdAt!);
        });
        break;
      case "exitTime":
        filterVisitor.sort((a, b) {
          return a.exitTime!.time!.compareTo(b.createdAt!);
        });
        break;
      case "-exitTime":
        filterVisitor.sort((b, a) {
          return a.exitTime!.time!.compareTo(b.createdAt!);
        });
        break;
      case "plateNumber":
        filterVisitor.sort((a, b) {
          return a.plateNumber!.compareTo(b.plateNumber!);
        });
        break;
      case "-plateNumber":
        filterVisitor.sort((b, a) {
          return a.plateNumber!.compareTo(b.plateNumber!);
        });
        break;
      case "memberName":
        filterVisitor.sort((a, b) {
          return a.member!.name!.compareTo(b.member!.name!);
        });
        break;
      case "-memberName":
        filterVisitor.sort((b, a) {
          return a.member!.name!.compareTo(b.member!.name!);
        });
        break;
      default:
    }
  }
  return filterVisitor;
});

class VisitorScreen extends ConsumerStatefulWidget {
  const VisitorScreen({super.key});

  @override
  ConsumerState<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends ConsumerState<VisitorScreen> {
  List<DateTime?> _dates = [DateTime.now()];
  int _selectedCol = 0;
  final _searchController = TextEditingController();

  void _selectDate(List<DateTime?> newSelectedDate) {
    getVisitorList(newSelectedDate);
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _selectDate([DateTime(now.year, now.month, now.day)]);
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

  Future<void> getVisitorList(List<DateTime?> selectedDate) async {
    EasyLoading.show(status: 'loading...');
    final visitors = ref.read(visitorsProvider.notifier);
    if (selectedDate.isNotEmpty) {
      var date = DateFormat('yyyy-MM-dd').format(selectedDate[0]!);
      var dateTo = date;
      if (selectedDate.length > 1) {
        dateTo = DateFormat('yyyy-MM-dd').format(selectedDate[1]!);
      }
      getIt<ApiService>()
          .listVisitor(getIt<AppService>().token, date, dateTo)
          .then((value) {
        EasyLoading.dismiss();
        visitors.setState(value);
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
    final filteredVisitors = ref.watch(filteredVisitorsProvider);
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
                  onPressedExportVisitor();
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
        VisitorHeaderCard(
          selectedColumn: _selectedCol,
          onTapDate: () {
            _selectedCol = 0;
            sortBy("date");
          },
          onTapExitTime: () {
            _selectedCol = 1;
            sortBy("exitTime");
          },
          onTapPlateNumber: () {
            _selectedCol = 2;
            sortBy("plateNumber");
          },
          onTapMemberName: () {
            _selectedCol = 3;
            sortBy("memberName");
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredVisitors.length,
            itemBuilder: (context, index) {
              return VisitorListCard(
                  visitor: filteredVisitors[index],
                  onTap: () => viewDetail(filteredVisitors[index]));
            },
          ),
        )
      ],
    );
  }

  void viewDetail(VisitorModel visitor) {
    context.push("${VisitorDetailScreen.routeName}/${visitor.id}");
  }

  Excel generateExcel() {
    final visitors = ref.read(filteredVisitorsProvider);
    Excel excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    int currentRow = 0;
    List<CellValue> columnName = [
      TextCellValue("createdAt"),
      TextCellValue("type"),
      TextCellValue("plateNumber"),
      TextCellValue("member.name"),
      TextCellValue("idCard"),
      TextCellValue("thaiName"),
      TextCellValue("engName"),
      TextCellValue("birthdate"),
      TextCellValue("gender"),
      TextCellValue("address"),
      TextCellValue("age"),
      TextCellValue("exitTime"),
      TextCellValue("image.type"),
      TextCellValue("image"),
    ];
    sheetObject.insertRowIterables(columnName, currentRow);
    CellStyle cellStyle = CellStyle(
        backgroundColorHex: ExcelColor.fromHexString('#C4D9C3'), bold: true);
    for (var i = 0; i < columnName.length; i++) {
      var cell = sheetObject.cell(
          CellIndex.indexByColumnRow(columnIndex: i, rowIndex: currentRow));
      cell.cellStyle = cellStyle;
    }

    for (var i = 0; i < visitors.length; i++) {
      currentRow++;
      var v = visitors[i];
      List<CellValue> dataList = [
        TextCellValue(v.dateTimeFormat()),
        TextCellValue(v.type!),
        TextCellValue(v.plateNumber!),
        TextCellValue(v.member!.name!),
        TextCellValue(v.idCard!),
        TextCellValue(v.thaiName!),
        TextCellValue(v.engName!),
        TextCellValue(v.birthdate!),
        TextCellValue(v.gender!),
        TextCellValue(v.address!),
        TextCellValue(v.age!),
        TextCellValue(
            v.exitTime!.valid! ? v.exitTime!.time!.toIso8601String() : ""),
      ];
      sheetObject.insertRowIterables(dataList, currentRow, startingColumn: 0);
      for (var j = 0; j < v.visitorImages!.length; j++) {
        if (j > 0) {
          currentRow++;
        }
        var image = v.visitorImages?[j];
        List<CellValue> vehicleList = [
          TextCellValue(image!.type),
          TextCellValue(image.imageUrl()),
        ];
        sheetObject.insertRowIterables(vehicleList, currentRow,
            startingColumn: 12);
      }
    }

    return excel;
  }

  void onPressedExportVisitor() async {
    String fileName = "visitor";
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
