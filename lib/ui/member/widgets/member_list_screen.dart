import 'dart:io';

import 'package:carpark/domain/models/member/member_model.dart';
import 'package:carpark/rounting/routes.dart';
import 'package:carpark/ui/member/bloc/member_list/member_list_bloc.dart';
import 'package:carpark/ui/member/widgets/member_header_card.dart';
import 'package:carpark/ui/member/widgets/member_list_card.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({super.key});

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  late MemberListBloc _memberListBloc;
  final _filterController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _memberListBloc = context.read<MemberListBloc>();
    _memberListBloc.add(LoadMemberList());
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: _filterController,
                  autocorrect: false,
                  onChanged: onSearchTextChanged,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _filterController.clear();
                        onSearchTextChanged('');
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
              onPressed: onPressedAddMember,
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
        BlocSelector<MemberListBloc, MemberListState, List<MemberModel>>(
          selector: (state) => state.filteredMembers,
          builder: (context, filteredMembers) {
            return Expanded(
              child: ListView.builder(
                itemCount: filteredMembers.length,
                itemBuilder: (context, index) {
                  return MemberListCard(
                    member: filteredMembers[index],
                    onTap: () => onPressedRow(context, filteredMembers[index]),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> onPressedRow(BuildContext context, MemberModel member) async {
    await context.push(Routes.memberWithId(member.id));
    _memberListBloc.add(LoadMemberList());
  }

  Future<void> onSearchTextChanged(String text) async {
    _memberListBloc.add(FilterMemberList(text));
  }

  Future<void> onPressedAddMember() async {
    await context.push(Routes.member);
    _memberListBloc.add(LoadMemberList());
  }

  Excel generateExcel() {
    final members = _memberListBloc.state.members;
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
    final outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'member_list_$dateTime.xlsx',
    );

    if (outputFile != null) {
      final file = File(outputFile);
      file.writeAsBytes(generateExcel().encode()!);
    }
  }
}
