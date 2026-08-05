import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/shared/config/constants.dart';
import 'package:carpark/shared/injector/injector.dart';
import 'package:carpark/shared/services/api/api_service.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<DateTime?> _dates = [DateTime.now()];
  String _reportType = 'member_traffic';

  void _selectDate(List<DateTime?> newSelectedDate) {
    // _dates
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectDate([DateTime(now.year, now.month, now.day)]);
  }

  void alertError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: downloadMemberTrafficExcel,
                child: const Text('Export to Excel', style: kButton2Style),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
        FormBuilderRadioGroup(
          initialValue: _reportType,
          name: 'type',
          onChanged: (value) {
            _reportType = value!;
          },
          validator: FormBuilderValidators.required<String>(),
          options: kReportTypeMap.entries
              .map(
                (e) =>
                    FormBuilderFieldOption(value: e.key, child: Text(e.value)),
              )
              .toList(growable: false),
        ),
      ],
    );
  }

  String createFileName(String fileName) {
    const dfConfig = 'yyyy-MM-dd';
    final df1 = DateFormat('_$dfConfig');
    final df2 = DateFormat('-$dfConfig');
    final ext = switch (_dates.length) {
      2 => '${df1.format(_dates[0]!)}${df2.format(_dates[1]!)}.xlsx',
      1 => '${df1.format(_dates[0]!)}.xlsx',
      _ => '.xlsx',
    };
    return fileName + ext;
  }

  Future<void> downloadMemberTrafficExcel() async {
    final date = DateFormat('yyyy-MM-dd').format(_dates[0]!);
    var dateTo = date;
    if (_dates.length > 1) {
      dateTo = DateFormat('yyyy-MM-dd').format(_dates[1]!);
    }
    await getIt<ApiService>().reportTraffic(_reportType, date, dateTo).then((
      report,
    ) async {
      final excel = Excel.createExcel();
      final sheetObject = excel['Sheet1'];

      var currentRow = 0;
      final columnName = <CellValue>[
        TextCellValue('ID'),
        TextCellValue('Name'),
        TextCellValue('Vehicle ID'),
        TextCellValue('PlateNumber'),
        TextCellValue('Traffic'),
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

      for (var i = 0; i < report.length; i++) {
        currentRow++;
        final m = report[i];
        final dataList = <CellValue>[
          TextCellValue(m.id.toString()),
          TextCellValue(m.name),
          TextCellValue(m.vehicleId.toString()),
          TextCellValue(m.plateNumber),
          TextCellValue(m.traffic.toString()),
        ];
        sheetObject.insertRowIterables(dataList, currentRow);
      }
      await saveExcelFile(excel, _reportType);
    });
  }

  Future<void> saveExcelFile(Excel excel, String reportType) async {
    final filename = createFileName(_reportType);
    if (kIsWeb) {
      excel.save(fileName: filename);
    } else {
      final outputFile = await FilePicker.saveFile(
        dialogTitle: 'Please select an output file:',
        fileName: filename,
      );

      if (outputFile != null) {
        final file = File(outputFile);
        await file.writeAsBytes(excel.encode()!);
      }
    }
  }
}
