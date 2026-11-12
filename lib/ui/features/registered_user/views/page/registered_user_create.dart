import 'dart:async';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/config/constants.dart';
import 'package:carpark/data/models/registered_user/create_registered_user_request.dart';
import 'package:carpark/routing/routes.dart';
import 'package:carpark/ui/features/registered_user/view_models/registered_user_create_viewmodel.dart';
import 'package:carpark/ui/features/registered_user/view_models/registered_user_list_viewmodel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class RegisteredUserCreate extends StatefulWidget {
  const new({
    required this.viewModel,
    required this.listViewModel,
    super.key,
  });

  final RegisteredUserCreateViewModel viewModel;
  final RegisteredUserListViewModel listViewModel;

  @override
  State<RegisteredUserCreate> createState() => _RegisteredUserCreateState();
}

class _RegisteredUserCreateState extends State<RegisteredUserCreate> {
  final TextEditingController _idCardController = TextEditingController();
  final TextEditingController _thaiNameController = TextEditingController();
  final TextEditingController _engNameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressNameController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _expiredDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _expiredDateController.text = widget.viewModel.expiredDate;
    widget.viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_onViewModelChanged);
    _idCardController.dispose();
    _thaiNameController.dispose();
    _engNameController.dispose();
    _birthdateController.dispose();
    _genderController.dispose();
    _addressNameController.dispose();
    _telephoneController.dispose();
    _typeController.dispose();
    _expiredDateController.dispose();
    super.dispose();
  }

  Future<void> _onViewModelChanged() async {
    final vm = widget.viewModel;
    switch (vm.status) {
      case RegisteredUserCreateStatus.initial:
      case RegisteredUserCreateStatus.selectExpiredDateSuccess:
        _expiredDateController.text = vm.expiredDate;
      case RegisteredUserCreateStatus.savingPhoto:
      case RegisteredUserCreateStatus.selectingExpiredDate:
        break;
      case RegisteredUserCreateStatus.reading:
      case RegisteredUserCreateStatus.creating:
        await EasyLoading.show();
      case RegisteredUserCreateStatus.readSuccess:
        _idCardController.text = vm.idCard;
        _thaiNameController.text = vm.thaiName;
        _engNameController.text = vm.engName;
        _birthdateController.text = vm.birthdate;
        _genderController.text = vm.gender;
        _addressNameController.text = vm.address;
        await EasyLoading.dismiss();
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('อ่านบัตรสำเร็จ')));
        }
      case RegisteredUserCreateStatus.createSuccess:
        await EasyLoading.dismiss();
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('สร้างผู้ใช้งานสำเร็จ')));
          unawaited(widget.listViewModel.getRegisteredUserList());
          await context.push(Routes.registeredUserLogsWithId(vm.id));
        }
      case RegisteredUserCreateStatus.savePhotoSuccess:
        await EasyLoading.dismiss();
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('บันทึกภาพสำเร็จ')));
        }
      case RegisteredUserCreateStatus.readFailure:
      case RegisteredUserCreateStatus.createFailure:
      case RegisteredUserCreateStatus.savePhotoFailure:
      case RegisteredUserCreateStatus.failure:
        await EasyLoading.dismiss();
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(vm.message)));
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final vm = widget.viewModel;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              ..._buildInputFields(vm),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      unawaited(vm.readIdCard());
                    },
                    child: const Text('อ่านบัตร'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      unawaited(
                        vm.createRegisteredUser(
                          CreateRegisteredUserRequest(
                            idCard: _idCardController.text,
                            engName: _engNameController.text,
                            thaiName: _thaiNameController.text,
                            birthdate: _birthdateController.text,
                            gender: _genderController.text,
                            address: _addressNameController.text,
                            telephone: _telephoneController.text,
                            type: _typeController.text,
                            expiredDate: _expiredDateController.text,
                          ),
                        ),
                      );
                    },
                    child: const Text('ยืนยัน'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      vm.initialize();
                      _idCardController.clear();
                      _thaiNameController.clear();
                      _engNameController.clear();
                      _birthdateController.clear();
                      _genderController.clear();
                      _addressNameController.clear();
                      _telephoneController.clear();
                      _typeController.clear();
                    },
                    child: const Text('ล้างข้อมูล'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      vm.initialize();
                      unawaited(widget.listViewModel.getRegisteredUserList());
                    },
                    child: const Text('ยกเลิก'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildInputFields(RegisteredUserCreateViewModel vm) {
    return [
      SizedBox(
        height: 120,
        child: vm.photoUrl.isNotEmpty
            ? Image.network(vm.photoUrl, fit: BoxFit.cover)
            : const Icon(size: 120, Icons.face),
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: _idCardController,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'เลขประจำตัวประชาชน',
                prefixIcon: Icon(Icons.text_fields),
                contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _birthdateController,
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'วันเกิด',
                prefixIcon: Icon(Icons.cake),
                contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: _thaiNameController,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'ชื่อไทย',
                prefixIcon: Icon(Icons.text_fields),
                contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _engNameController,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'ชื่ออังกฤษ',
                prefixIcon: Icon(Icons.text_fields),
                contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: _telephoneController,
              autocorrect: false,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'เบอร์โทรศัพท์',
                prefixIcon: Icon(Icons.phone),
                contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _genderController,
              autocorrect: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'เพศ',
                prefixIcon: Icon(Icons.wc),
                contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              ),
            ),
          ),
        ],
      ),
      TextField(
        controller: _addressNameController,
        autocorrect: false,
        keyboardType: TextInputType.streetAddress,
        decoration: const InputDecoration(
          labelText: 'ที่อยู่',
          prefixIcon: Icon(Icons.location_city),
          contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        ),
        textInputAction: TextInputAction.next,
      ),
      Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: FormBuilderRadioGroup(
                decoration: InputDecoration(
                  labelText: 'ประเภท',
                  prefixIcon: const Icon(Icons.group),
                  contentPadding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialValue:
                    kRegisteredUserTypeList.any((type) => type == vm.type)
                    ? vm.type
                    : 'อื่นๆ',
                name: 'type',
                onChanged: (value) {
                  _typeController.text = value ?? '';
                  if (value == 'อื่นๆ') {
                    _typeController.text = '';
                  }
                  setState(() {});
                },
                validator: FormBuilderValidators.required<String>(),
                options: kRegisteredUserTypeList
                    .map((lang) => FormBuilderFieldOption(value: lang))
                    .toList(growable: false),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _typeController,
              readOnly: kRegisteredUserTypeList.any(
                (type) => type == _typeController.text,
              ),
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'ประเภทอื่นๆ ระบุ',
                contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          Expanded(
            child: TextField(
              onTap: () async {
                final results = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(
                    calendarType: CalendarDatePicker2Type.single,
                  ),
                  dialogSize: const Size(325, 400),
                  value: [DateTime.parse(vm.expiredDate)],
                  borderRadius: BorderRadius.circular(15),
                );
                if (results != null) {
                  vm.selectExpiredDate(results);
                }
              },
              controller: _expiredDateController,
              autocorrect: false,
              readOnly: true,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'วันหมดอายุ',
                prefixIcon: Icon(Icons.group),
                contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
    ];
  }
}
