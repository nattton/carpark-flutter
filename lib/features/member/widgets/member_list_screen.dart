import 'dart:io';

import 'package:carpark/features/member/view_models/member_list_viewmodel.dart';
import 'package:carpark/features/member/widgets/member_header_card.dart';
import 'package:carpark/features/member/widgets/member_list_view.dart';
import 'package:carpark/shared/injector/injector.dart';
import 'package:carpark/shared/rounting/routes.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MemberListScreen extends WatchingWidget {
  const MemberListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    callOnce((_) => getIt<MemberListViewModel>().getMemberListCommand());

    final filterController = createOnce(TextEditingController.new);

    registerHandler(
      select: (MemberListViewModel viewModel) =>
          viewModel.getMemberListCommand.isRunning,
      handler: (context, isRunning, cancel) async {
        if (isRunning) {
          await EasyLoading.show();
        } else {
          await EasyLoading.dismiss();
        }
      },
    );

    registerHandler(
      select: (MemberListViewModel viewModel) =>
          viewModel.goMemberScreenCommand,
      handler: (context, memberId, _) async {
        await context.push(Routes.memberWithId(memberId));
      },
    );

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: filterController,
                  autocorrect: false,
                  onChanged: (value) =>
                      getIt<MemberListViewModel>().filterChangedCommand(value),
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        filterController.clear();
                        getIt<MemberListViewModel>().filterChangedCommand('');
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
            ),
            IconButton(
              onPressed:
                  getIt<MemberListViewModel>().goMemberScreenCommand.call,
              icon: const Icon(Icons.person_add),
              tooltip: 'สร้างสมาชิกใหม่',
            ),
            IconButton(
              onPressed: onPressedExportMember,
              icon: const Icon(Icons.download),
              tooltip: 'Export Member',
            ),
          ],
        ),
        const MemberHeaderCard(),
        const Expanded(
          child: MemberListView(),
        ),
      ],
    );
  }

  Excel generateExcel() {
    final members = getIt<MemberListViewModel>().memberListCommand.value;
    final excel = Excel.createExcel();
    final sheetObject = excel['Sheet1'];

    var currentRow = 0;
    final columnName = <CellValue>[
      TextCellValue('id'),
      TextCellValue('name'),
      TextCellValue('telephone'),
      TextCellValue('type'),
      TextCellValue('status'),
      TextCellValue('vehicleId'),
      TextCellValue('plateNumber'),
      TextCellValue('resemble'),
      TextCellValue('plateProvince'),
      TextCellValue('brand'),
      TextCellValue('color'),
      TextCellValue('telephone'),
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

    for (var i = 0; i < members.length; i++) {
      currentRow++;
      final m = members[i];
      final dataList = <CellValue>[
        TextCellValue(m.id.toString()),
        TextCellValue(m.name!),
        TextCellValue(m.telephone!),
        TextCellValue(m.type!),
        TextCellValue(m.status!),
      ];
      sheetObject.insertRowIterables(dataList, currentRow);
      for (var j = 0; j < m.vehicles!.length; j++) {
        if (j > 0) {
          currentRow++;
        }
        final v = m.vehicles?[j];
        final vehicleList = <CellValue>[
          TextCellValue(v!.id.toString()),
          TextCellValue(v.plateNumber!),
          TextCellValue(v.resemble!),
          TextCellValue(v.plateProvince!),
          TextCellValue(v.brand!),
          TextCellValue(v.color!),
          TextCellValue(v.telephone!),
        ];
        sheetObject.insertRowIterables(
          vehicleList,
          currentRow,
          startingColumn: 5,
        );
      }
    }
    return excel;
  }

  Future<void> onPressedExportMember() async {
    final dateTime = DateFormat('yyyy-MM-dd_HH-mm').format(DateTime.now());
    final outputFile = await FilePicker.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'member_list_$dateTime.xlsx',
    );

    if (outputFile != null) {
      final file = File(outputFile);
      await file.writeAsBytes(generateExcel().encode()!);
    }
  }
}
