import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/features/visitor/view_models/visitor_viewmodel.dart';
import 'package:carpark/features/visitor/widgets/visitor_header_card.dart';
import 'package:carpark/features/visitor/widgets/visitor_list_card.dart';
import 'package:carpark/shared/config/constants.dart';
import 'package:carpark/shared/injector/injector.dart';
import 'package:carpark/shared/models/visitor_model.dart';
import 'package:carpark/shared/rounting/routes.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class VisitorScreen extends WatchingStatefulWidget {
  const VisitorScreen({super.key});

  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  List<DateTime?> _dates = [DateTime.now()];
  int _selectedCol = 0;

  void _selectDate(List<DateTime?> newSelectedDate) {
    getIt<VisitorViewmodel>().getVisitorsCommand.run(newSelectedDate);
  }

  void sortBy(String fieldName) {
    getIt<VisitorViewmodel>().sortByChangedCommand.run(fieldName);
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

    registerHandler(
      select: (VisitorViewmodel viewModel) =>
          viewModel.getVisitorsCommand.isRunning,
      handler: (context, isRunning, cancel) async {
        if (isRunning) {
          await EasyLoading.show();
        } else {
          await EasyLoading.dismiss();
        }
      },
    );

    final filteredVisitors = watchValue(
      (VisitorViewmodel viewModel) => viewModel.filteredVisitorsCommand,
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
                onPressed: onPressedExportVisitor,
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
                getIt<VisitorViewmodel>().filterChangedCommand(value),
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: GestureDetector(
                onTap: () {
                  searchController.clear();
                  getIt<VisitorViewmodel>().filterChangedCommand('');
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
        VisitorHeaderCard(
          selectedColumn: _selectedCol,
          onTapDate: () {
            _selectedCol = 0;
            sortBy('date');
          },
          onTapExitTime: () {
            _selectedCol = 1;
            sortBy('exitTime');
          },
          onTapPlateNumber: () {
            _selectedCol = 2;
            sortBy('plateNumber');
          },
          onTapMemberName: () {
            _selectedCol = 3;
            sortBy('memberName');
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredVisitors.length,
            itemBuilder: (context, index) {
              return VisitorListCard(
                visitor: filteredVisitors[index],
                onTap: () => viewDetail(filteredVisitors[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  void viewDetail(VisitorModel visitor) {
    context.push(Routes.visitorWithId(visitor.id));
  }

  Excel generateExcel() {
    final visitors = getIt<VisitorViewmodel>().filteredVisitorsCommand.value;
    final excel = Excel.createExcel();
    final sheetObject = excel['Sheet1'];

    var currentRow = 0;
    final columnName = <CellValue>[
      TextCellValue('createdAt'),
      TextCellValue('type'),
      TextCellValue('plateNumber'),
      TextCellValue('member.name'),
      TextCellValue('idCard'),
      TextCellValue('thaiName'),
      TextCellValue('engName'),
      TextCellValue('birthdate'),
      TextCellValue('gender'),
      TextCellValue('address'),
      TextCellValue('age'),
      TextCellValue('exitTime'),
      TextCellValue('image.type'),
      TextCellValue('image'),
    ];
    sheetObject.insertRowIterables(columnName, currentRow);
    final cellStyle = CellStyle(
      backgroundColorHex: ExcelColor.fromHexString('#C4D9C3'),
      bold: true,
    );
    for (var i = 0; i < columnName.length; i++) {
      final cell = sheetObject.cell(
        CellIndex.indexByColumnRow(columnIndex: i, rowIndex: currentRow),
      );
      cell.cellStyle = cellStyle;
    }

    for (var i = 0; i < visitors.length; i++) {
      currentRow++;
      final v = visitors[i];
      final dataList = <CellValue>[
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
          v.exitTime!.valid! ? v.exitTime!.time!.toIso8601String() : '',
        ),
      ];
      sheetObject.insertRowIterables(dataList, currentRow);
      for (var j = 0; j < v.visitorImages!.length; j++) {
        if (j > 0) {
          currentRow++;
        }
        final image = v.visitorImages?[j];
        final vehicleList = <CellValue>[
          TextCellValue(image!.type),
          TextCellValue(image.imageUrl()),
        ];
        sheetObject.insertRowIterables(
          vehicleList,
          currentRow,
          startingColumn: 12,
        );
      }
    }

    return excel;
  }

  Future<void> onPressedExportVisitor() async {
    var fileName = 'visitor';
    final date = DateFormat('_yyyy-MM-dd').format(_dates[0]!);
    fileName = '$fileName$date';

    if (_dates.length > 1) {
      final dateTo = DateFormat('_yyyy-MM-dd').format(_dates[1]!);
      fileName = '$fileName-$dateTo';
    }

    final filter = getIt<VisitorViewmodel>().filterChangedCommand.value;
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
