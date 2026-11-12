import 'dart:async';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/config/constants.dart';
import 'package:carpark/data/models/registered_user/update_registered_user_request.dart';
import 'package:carpark/ui/features/registered_user/view_models/registered_user_list_viewmodel.dart';
import 'package:carpark/ui/features/registered_user/view_models/registered_user_update_viewmodel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_ui/material_ui.dart';

class RegisteredUserUpdateScreen extends StatefulWidget {
  const new({
    required this.viewModel,
    required this.listViewModel,
    super.key,
  });

  final RegisteredUserUpdateViewModel viewModel;
  final RegisteredUserListViewModel listViewModel;

  @override
  State<RegisteredUserUpdateScreen> createState() =>
      _RegisteredUserUpdateScreenState();
}

class _RegisteredUserUpdateScreenState
    extends State<RegisteredUserUpdateScreen> {
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
      case RegisteredUserUpdateStatus.initial:
      case RegisteredUserUpdateStatus.selectingExpiredDate:
      case RegisteredUserUpdateStatus.selectType:
        break;
      case RegisteredUserUpdateStatus.selectExpiredDateSuccess:
        _expiredDateController.text = vm.registeredUser.expiredDate!
            .toDateString();
      case RegisteredUserUpdateStatus.loading:
      case RegisteredUserUpdateStatus.updating:
        await EasyLoading.show();
      case RegisteredUserUpdateStatus.loadSuccess:
        _idCardController.text = vm.registeredUser.idCard;
        _thaiNameController.text = vm.registeredUser.thaiName;
        _engNameController.text = vm.registeredUser.engName;
        _birthdateController.text = vm.registeredUser.birthdate;
        _genderController.text = vm.registeredUser.gender;
        _addressNameController.text = vm.registeredUser.address;
        _telephoneController.text = vm.registeredUser.telephone;
        _typeController.text = vm.registeredUser.type;
        _expiredDateController.text = vm.registeredUser.expiredDate!
            .toDateString();
        await EasyLoading.dismiss();
      case RegisteredUserUpdateStatus.updateSuccess:
        await EasyLoading.dismiss();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('อัพเดทผู้ใช้งานสำเร็จ')),
          );
          unawaited(widget.listViewModel.getRegisteredUserList());
        }
      case RegisteredUserUpdateStatus.loadFailure:
      case RegisteredUserUpdateStatus.updateFailure:
      case RegisteredUserUpdateStatus.failure:
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
        switch (vm.status) {
          case RegisteredUserUpdateStatus.initial:
          case RegisteredUserUpdateStatus.loading:
          case RegisteredUserUpdateStatus.updating:
          case RegisteredUserUpdateStatus.failure:
          case RegisteredUserUpdateStatus.loadFailure:
            return const SizedBox();
          case RegisteredUserUpdateStatus.updateFailure:
          case RegisteredUserUpdateStatus.loadSuccess:
          case RegisteredUserUpdateStatus.updateSuccess:
          case RegisteredUserUpdateStatus.selectingExpiredDate:
          case RegisteredUserUpdateStatus.selectExpiredDateSuccess:
          case RegisteredUserUpdateStatus.selectType:
            break;
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              ..._buildInputFields(vm),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      unawaited(
                        vm.updateRegisteredUser(
                          UpdateRegisteredUserRequest(
                            id: vm.registeredUser.id,
                            idCard: _idCardController.text,
                            engName: _engNameController.text,
                            thaiName: _thaiNameController.text,
                            birthdate: _birthdateController.text,
                            gender: _genderController.text,
                            address: _addressNameController.text,
                            telephone: _telephoneController.text,
                            type: _typeController.text,
                            expiredDate: vm.registeredUser.expiredDate!
                                .toDateString(),
                          ),
                        ),
                      );
                    },
                    child: const Text('ยืนยัน'),
                  ),
                  const SizedBox(width: 32),
                  ElevatedButton(
                    onPressed: () {
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

  List<Widget> _buildInputFields(RegisteredUserUpdateViewModel vm) {
    return [
      SizedBox(
        height: 120,
        child: vm.registeredUser.photoUrl().isNotEmpty
            ? Image.network(vm.registeredUser.photoUrl(), fit: BoxFit.cover)
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
                    kRegisteredUserTypeList.any(
                      (type) => type == vm.registeredUser.type,
                    )
                    ? vm.registeredUser.type
                    : 'อื่นๆ',
                name: 'type',
                onChanged: (value) {
                  _typeController.text = value ?? '';
                  if (value == 'อื่นๆ') {
                    _typeController.text = '';
                  }
                  vm.selectType(value ?? '');
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
                labelText: 'ประเภท',
                prefixIcon: Icon(Icons.group),
                contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final results = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(
                    calendarType: CalendarDatePicker2Type.single,
                  ),
                  dialogSize: const Size(325, 400),
                  value: [
                    if (vm.registeredUser.expiredDate!.valid!)
                      vm.registeredUser.expiredDate!.time!
                    else
                      DateTime.now(),
                  ],
                  borderRadius: BorderRadius.circular(15),
                );
                if (results != null) {
                  vm.selectExpiredDate(results);
                }
              },
              child: TextField(
                onTap: () async {
                  final results = await showCalendarDatePicker2Dialog(
                    context: context,
                    config: CalendarDatePicker2WithActionButtonsConfig(
                      calendarType: CalendarDatePicker2Type.single,
                    ),
                    dialogSize: const Size(325, 400),
                    value: [
                      if (vm.registeredUser.expiredDate!.valid!)
                        vm.registeredUser.expiredDate!.time!
                      else
                        DateTime.now(),
                    ],
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
                decoration: InputDecoration(
                  labelText: 'วันหมดอายุ',
                  prefixIcon: GestureDetector(child: const Icon(Icons.group)),
                  contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
