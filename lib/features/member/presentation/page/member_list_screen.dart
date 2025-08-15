import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../constants.dart';
import '../../../../data/services/api_service.dart';
import '../../../../injector/injector.dart';
import '../../../../models/member_model.dart';
import '../../../../services/app_service.dart';
import '../bloc/member_list/member_list_bloc.dart';
import '../widget/member_header_card.dart';
import '../widget/member_list_card.dart';
import 'member_screen.dart';

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({super.key});

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  late MemberListBloc _memberListBloc;
  final MemberModel _memberModel = MemberModel(id: 0, vehicles: []);
  final _nameController = TextEditingController();
  final _telController = TextEditingController();
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
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _filterController,
                  autofocus: false,
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
                    contentPadding: const EdgeInsets.all(20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                onPressedAddMember();
              },
              icon: const Icon(Icons.person_add),
              tooltip: 'สร้างสมาชิกใหม่',
            ),
            IconButton(
              onPressed: () {
                onPressedExportMember();
              },
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

  void onPressedRow(BuildContext context, MemberModel member) async {
    context.push("${MemberScreen.routeName}/${member.id}").then((value) {
      _memberListBloc.add(LoadMemberList());
    });
  }

  void onSearchTextChanged(String text) async {
    _memberListBloc.add(FilterMemberList(text));
  }

  void onPressedAddMember() {
    _memberModel.name = '';
    _memberModel.telephone = '';
    _memberModel.type = 'resident';
    _memberModel.status = 'active';

    _nameController.text = '';
    _telController.text = '';

    Alert(
      context: context,
      title: "สร้างสมาชิกใหม่",
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              onChanged: (value) {
                _memberModel.name = value;
              },
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'ชื่อ',
                suffixIcon: const Icon(Icons.account_circle),
                contentPadding: const EdgeInsets.fromLTRB(
                  20.0,
                  20.0,
                  20.0,
                  20.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _telController,
              onChanged: (value) {
                _memberModel.telephone = value;
              },
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'โทรศัพท์.',
                suffixIcon: const Icon(Icons.phone),
                contentPadding: const EdgeInsets.fromLTRB(
                  20.0,
                  20.0,
                  20.0,
                  20.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderRadioGroup(
              decoration: InputDecoration(
                labelText: 'ประเภท',
                contentPadding: const EdgeInsets.fromLTRB(
                  20.0,
                  20.0,
                  20.0,
                  20.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              initialValue: _memberModel.type,
              name: 'type',
              onChanged: (value) {
                _memberModel.type = value;
              },
              validator: FormBuilderValidators.required(),
              options: kMemberTypeList
                  .map((lang) => FormBuilderFieldOption(value: lang))
                  .toList(growable: false),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderRadioGroup(
              decoration: InputDecoration(
                labelText: 'สถานะ',
                contentPadding: const EdgeInsets.fromLTRB(
                  20.0,
                  20.0,
                  20.0,
                  20.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              initialValue: _memberModel.status,
              name: 'status',
              onChanged: (value) {
                _memberModel.status = value;
              },
              validator: FormBuilderValidators.required(),
              options: kStatusList
                  .map((lang) => FormBuilderFieldOption(value: lang))
                  .toList(growable: false),
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            createMember();
          },
          child: const Text(
            "สร้าง",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  void createMember() {
    getIt<ApiService>()
        .createMember(getIt<AppService>().token, _memberModel)
        .then((value) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Create Member'),
              content: const Text('สร้างข้อมูลสมาชิกเรียบร้อย'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    context.pop();
                    context.pop();
                    _memberListBloc.add(LoadMemberList());
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        })
        .onError((error, stackTrace) {
          alertError(error.toString());
        });
  }

  Excel generateExcel() {
    final members = _memberListBloc.state.members;
    final excel = Excel.createExcel();
    final sheetObject = excel['Sheet1'];

    var currentRow = 0;
    final columnName = <CellValue>[
      TextCellValue("id"),
      TextCellValue("name"),
      TextCellValue("telephone"),
      TextCellValue("type"),
      TextCellValue("status"),
      TextCellValue("vehicleId"),
      TextCellValue("plateNumber"),
      TextCellValue("resemble"),
      TextCellValue("plateProvince"),
      TextCellValue("brand"),
      TextCellValue("color"),
      TextCellValue("telephone"),
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
      sheetObject.insertRowIterables(dataList, currentRow, startingColumn: 0);
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

  void onPressedExportMember() async {
    final dateTime = DateFormat("yyyy-MM-dd_HH-mm").format(DateTime.now());
    final outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'member_list_$dateTime.xlsx',
    );

    if (outputFile != null) {
      final file = File(outputFile);
      file.writeAsBytes(generateExcel().encode()!);
    }
  }

  void alertError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
