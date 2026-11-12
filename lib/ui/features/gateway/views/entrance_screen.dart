import 'dart:async';
import 'dart:io';

import 'package:carpark/config/constants.dart';
import 'package:carpark/config/injector.dart';
import 'package:carpark/domain/models/gate_log_model.dart';
import 'package:carpark/domain/models/member_model.dart';
import 'package:carpark/domain/models/visitor_model.dart';
import 'package:carpark/ui/features/gateway/view_models/entrance_viewmodel.dart';
import 'package:carpark/ui/features/gateway/views/entrance_card.dart';
import 'package:carpark/ui/features/gateway/views/exit_card.dart';
import 'package:carpark/ui/features/home/view_models/last_gate_viewmodel.dart';
import 'package:carpark/ui/features/live_player/view_models/live_player_viewmodel.dart';
import 'package:carpark/ui/features/live_player/views/card_player_widget.dart';
import 'package:carpark/ui/features/live_player/views/live_player_widget.dart';
import 'package:carpark/ui/features/member/view_models/member_list_viewmodel.dart';
import 'package:carpark/ui/features/registered_user_check_in/registered_user_check_in.dart';
import 'package:carpark/utils/result.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:substring_highlight/substring_highlight.dart';

enum EntranceScreenLeftState { initial, visitor }

class EntranceScreen extends WatchingStatefulWidget {
  const new({super.key});

  @override
  State<EntranceScreen> createState() => _EntranceScreenState();
}

class _EntranceScreenState extends State<EntranceScreen> {
  final _log = Logger('EntranceScreen');

  late final EntranceViewModel _viewModel;
  late FocusNode focusNode;

  EntranceScreenLeftState _leftState = EntranceScreenLeftState.initial;
  bool _isReadDrivingLicence = false;
  bool _isReadCard = false;
  String _vehicleType = 'car';

  File? _photoFile;
  int _selectedGateLogId = 0;

  MemberModel? _selectedMember;
  TextEditingController _memberController = TextEditingController();

  final _drivingLicenceController = TextEditingController();

  final _plateNumberController = TextEditingController();
  final _idCardController = TextEditingController();
  final _thaiNameController = TextEditingController();
  final _engNameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _genderController = TextEditingController();
  final _addressNameController = TextEditingController();
  final _barcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<EntranceViewModel>();
    focusNode = FocusNode();
    getIt<MemberListViewModel>().getMemberListCommand();
    getIt<LivePlayerViewmodel>().getCameraCommand.run();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    focusNode.dispose();
    _plateNumberController.dispose();
    _idCardController.dispose();
    _thaiNameController.dispose();
    _engNameController.dispose();
    _birthdateController.dispose();
    _genderController.dispose();
    _addressNameController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gateLogIn = watchValue(
      (LastGateViewmodel viewModel) => viewModel.gateIn,
    );

    return gateLogIn.id != 0
        ? Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              top: 8,
                              right: 8,
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: RegisteredUserCheckInWidget(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child:
                                      _leftState ==
                                          EntranceScreenLeftState.visitor
                                      ? ElevatedButton(
                                          onPressed: openVisitior,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                          ),
                                          child: const Text(
                                            'ยกเลิก',
                                            style: kButtonStyle,
                                          ),
                                        )
                                      : ElevatedButton(
                                          onPressed: showVisitorFromEmpty,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                kColorButtonPrimary,
                                          ),
                                          child: const Text(
                                            'สร้างผู้ติดต่อ',
                                            style: kButtonStyle,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      switch (_leftState) {
                        EntranceScreenLeftState.visitor => _buildVisitorForm(),
                        _ => _buildViewer(),
                      },
                    ],
                  ),
                ),
                const Expanded(
                  child: !kIsWeb
                      ? LivePlayerWidget()
                      : Column(children: [ExitCard()]),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _buildViewer() {
    final gateLogIn = getIt<LastGateViewmodel>().gateIn.value;
    return EntranceCard(
      gateLog: gateLogIn,
      onTapSelectGateLog: () => showVisitorFromSelect(gateLogIn),
    );
  }

  Widget _buildVisitorForm() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(child: Text('ประเภท', style: kGateStyle)),
                ),
                Expanded(
                  child: FormBuilderRadioGroup(
                    initialValue: _vehicleType,
                    name: 'type',
                    onChanged: (value) {
                      _vehicleType = value!;
                    },
                    validator: FormBuilderValidators.required<String>(),
                    options: kVehicleTypeMap.entries
                        .map(
                          (e) => FormBuilderFieldOption(
                            value: e.key,
                            child: Text(e.value),
                          ),
                        )
                        .toList(growable: false),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _plateNumberController,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        labelText: 'เลขทะเบียน',
                        suffixIcon: const Icon(Icons.directions_car),
                        contentPadding: const EdgeInsets.all(8),
                      ),
                    ),
                  ),
                  Expanded(child: _buildSearchMember()),
                ],
              ),
            ),
            Container(
              height: 60,
              color: Colors.white10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: readSmartCardFromService,
                    child: const Text('อ่านบัตรปชช.', style: kButtonStyle),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 161, 80, 175),
                    ),
                    onPressed: inputDrivingLicence,
                    child: const Text('อ่านใบขับขี่', style: kButtonStyle),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: clearForm,
                    child: const Text('ล้างข้อมูล', style: kButtonStyle),
                  ),
                  ElevatedButton(
                    onPressed: saveAndPrint,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kColorButtonPrimary,
                    ),
                    child: const Text('บันทึกและพิมพ์', style: kButtonStyle),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isReadDrivingLicence,
              child: TextField(
                controller: _drivingLicenceController,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                minLines: 7,
                maxLines: 7,
                decoration: const InputDecoration(
                  labelText: 'ข้อมูลใบขับขี่',
                  contentPadding: EdgeInsets.all(8),
                ),
                onChanged: readDrivingLicence,
                focusNode: focusNode,
              ),
            ),
            Visibility(
              visible: _isReadCard,
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                },
                children: [
                  TableRow(
                    children: <Widget>[
                      SizedBox(
                        height: 120,
                        child: _photoFile != null
                            ? Image.file(_photoFile!)
                            : const Icon(size: 120, Icons.face),
                      ),
                      TextField(
                        controller: _idCardController,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'เลขประจำตัวประชาชน',
                          suffixIcon: Icon(Icons.text_fields),
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TextField(
                        controller: _thaiNameController,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'ชื่อไทย',
                          suffixIcon: Icon(Icons.text_fields),
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                      TextField(
                        controller: _engNameController,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'ชื่ออังกฤษ',
                          suffixIcon: Icon(Icons.text_fields),
                          contentPadding: EdgeInsets.all(8),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TextField(
                        controller: _birthdateController,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'วันเกิด',
                          suffixIcon: Icon(Icons.cake),
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                      TextField(
                        controller: _genderController,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'เพศ',
                          suffixIcon: Icon(Icons.wc),
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TextField(
                        controller: _addressNameController,
                        autocorrect: false,
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                          labelText: 'ที่อยู่',
                          suffixIcon: Icon(Icons.location_city),
                          contentPadding: EdgeInsets.all(8),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      Container(),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !_isReadDrivingLicence && !_isReadCard,
              child: const CardPlayerWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showVisitorFromSelect(GateLogModel gateLog) async {
    _selectedMember = null;
    _plateNumberController.text = gateLog.plateNumber!;
    _selectedGateLogId = gateLog.id;
    if (gateLog.memberId != 0 && gateLog.member!.status == 'overdue') {
      _selectedMember = gateLog.member;
    }

    await openVisitior();
  }

  Future<void> showVisitorFromEmpty() async {
    _selectedMember = null;
    _plateNumberController.clear();
    _selectedGateLogId = 0;
    await openVisitior();
  }

  Future<void> openVisitior() async {
    setState(() {
      clearForm();
      _vehicleType = 'car';

      _leftState = _leftState == EntranceScreenLeftState.initial
          ? EntranceScreenLeftState.visitor
          : EntranceScreenLeftState.initial;

      _isReadCard = false;
      _isReadDrivingLicence = false;
    });
  }

  Future<void> manualCapture(String door) async {
    final result = await _viewModel.manualCapture(door);
    if (result is Error<void>) {
      alertError(result.error.toString());
    }
  }

  void clearForm() {
    _drivingLicenceController.clear();
    _photoFile = null;
    _idCardController.clear();
    _thaiNameController.clear();
    _engNameController.clear();
    _birthdateController.clear();
    _genderController.clear();
    _addressNameController.clear();
    setState(() {});
  }

  Future<void> inputDrivingLicence() async {
    focusNode.requestFocus();
    clearForm();
    _drivingLicenceController.text = '';
    _isReadDrivingLicence = true;
    _isReadCard = false;
  }

  void readDrivingLicence(String value) {
    final count = '\n'.allMatches(value).length;
    _log.info('count: $count');
    if (count == 6) {
      final lines = value.split('\n');

      final name = lines[0];
      final idNumber = lines[2];
      final licenceNumber = lines[4];

      _log
        ..info('Name : $name')
        ..info('idNumber : $idNumber')
        ..info('licenceNumber : $licenceNumber');

      final nameList = name.split(r'$').reversed.toList();
      for (var i = 0; i < nameList.length; i++) {
        nameList[i] = nameList[i].replaceAll('\n', ' ');
        _log.info(nameList[i]);
      }
      final nameEng = nameList.join(' ');
      _log.info('NameEng : $nameEng');
    }
  }

  Future<void> readSmartCardFromService() async {
    clearForm();
    await EasyLoading.show();
    _isReadDrivingLicence = false;
    _isReadCard = true;
    final result = await _viewModel.readSmartCard();
    switch (result) {
      case Error<SmartCardReadResult>():
        alertError(result.error.toString());
        await EasyLoading.dismiss();
      case Ok<SmartCardReadResult>():
        final data = result.value;
        _photoFile = data.photoFile;
        _idCardController.text = data.card.id;
        _thaiNameController.text = data.card.thaiName;
        _engNameController.text = data.card.engName;
        _birthdateController.text = data.card.birthdate;
        _genderController.text = data.card.genderName();
        _addressNameController.text = data.card.address;
        await EasyLoading.dismiss();
        setState(() {});
    }
  }

  Future<void> saveAndPrint() async {
    if (_selectedMember == null) {
      alertError('เลือกบ้านที่ติดต่อ');
      return;
    }

    final visitor = VisitorModel(
      0,
      type: _vehicleType,
      plateNumber: _plateNumberController.text,
      memberId: _selectedMember?.id,
      gateLogId: _selectedGateLogId,
      idCard: _idCardController.text.replaceAll(' ', ''),
      thaiName: _thaiNameController.text,
      engName: _engNameController.text,
      birthdate: _birthdateController.text,
      gender: _genderController.text,
      address: _addressNameController.text,
      visitorImages: [],
    );

    final result = await _viewModel.saveAndPrintVisitor(
      visitor: visitor,
      selectedMember: _selectedMember!,
      photoFile: _photoFile,
    );
    switch (result) {
      case Ok<VisitorModel>():
        setState(() {
          _leftState = EntranceScreenLeftState.initial;
          _isReadCard = false;
        });
      case Error<VisitorModel>():
        alertError(result.error.toString());
    }
  }

  Widget _buildSearchMember() {
    final members = getIt<MemberListViewModel>().memberListCommand.value;
    return Autocomplete<MemberModel>(
      initialValue:
          _selectedMember != null && _selectedMember!.status == 'overdue'
          ? TextEditingValue(text: _selectedMember!.name!)
          : null,
      displayStringForOption: (MemberModel member) {
        return member.name!;
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable.empty();
        }
        return members.where(
          (MemberModel member) => member.name!.contains(textEditingValue.text),
        );
      },
      onSelected: (MemberModel member) {
        _selectedMember = member;
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Material(
          elevation: 4,
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final option = options.elementAt(index);
              return ListTile(
                title: SubstringHighlight(
                  text: option.name!,
                  term: _memberController.text,
                  textStyleHighlight: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  option.vehicles != null
                      ? option.vehicles!
                            .map((vehicle) => vehicle.plateNumber!)
                            .join(', ')
                      : '',
                ),
                onTap: () {
                  onSelected(option);
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: options.length,
          ),
        );
      },
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        _memberController = controller;

        return TextField(
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            labelText: 'ติดต่อ',
            prefixIcon: const Icon(Icons.search),
          ),
        );
      },
    );
  }

  void alertMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void alertError(String msg) {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error Message'),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
