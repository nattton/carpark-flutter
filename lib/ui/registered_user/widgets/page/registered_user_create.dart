import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/config/constants.dart';
import 'package:carpark/data/services/api/model/registered_user/create_registered_user_request.dart';
import 'package:carpark/rounting/routes.dart';
import 'package:carpark/ui/registered_user/bloc/registered_user_create/registered_user_create_bloc.dart';
import 'package:carpark/ui/registered_user/bloc/registered_user_list/registered_user_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class RegisteredUserCreate extends StatefulWidget {
  const RegisteredUserCreate({super.key});

  @override
  State<RegisteredUserCreate> createState() => _RegisteredUserCreateState();
}

class _RegisteredUserCreateState extends State<RegisteredUserCreate> {
  late RegisteredUserCreateBloc _registeredUserCreateBloc;

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
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    _registeredUserCreateBloc = context.read<RegisteredUserCreateBloc>();
    return BlocConsumer<RegisteredUserCreateBloc, RegisteredUserCreateState>(
      listener: (context, state) {
        switch (state.status) {
          case RegisteredUserCreateStatus.initial:
          case RegisteredUserCreateStatus.savingPhoto:
          case RegisteredUserCreateStatus.selectingExpiredDate:
          case RegisteredUserCreateStatus.selectExpiredDateSuccess:
            break;
          case RegisteredUserCreateStatus.reading:
          case RegisteredUserCreateStatus.creating:
            EasyLoading.show();
          case RegisteredUserCreateStatus.readSuccess:
            EasyLoading.dismiss();
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('อ่านบัตรสำเร็จ')));
          case RegisteredUserCreateStatus.createSuccess:
            EasyLoading.dismiss();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('สร้างผู้ใช้งานสำเร็จ')),
            );
            context.read<RegisteredUserListBloc>().add(GetRegisteredUserList());
            context.push(Routes.registeredUserLogsWithId(state.id));
          case RegisteredUserCreateStatus.savePhotoSuccess:
            EasyLoading.dismiss();
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('บันทึกภาพสำเร็จ')));
          case RegisteredUserCreateStatus.readFailure:
          case RegisteredUserCreateStatus.createFailure:
          case RegisteredUserCreateStatus.savePhotoFailure:
          case RegisteredUserCreateStatus.failure:
            EasyLoading.dismiss();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state.status == RegisteredUserCreateStatus.readSuccess) {
          _idCardController.text = state.idCard;
          _thaiNameController.text = state.thaiName;
          _engNameController.text = state.engName;
          _birthdateController.text = state.birthdate;
          _genderController.text = state.gender;
          _addressNameController.text = state.address;
        }

        if (state.status == RegisteredUserCreateStatus.initial ||
            state.status ==
                RegisteredUserCreateStatus.selectExpiredDateSuccess) {
          _expiredDateController.text = state.expiredDate;
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              ..._buildInputFields(state),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _registeredUserCreateBloc.add(ReadIdCard());
                    },
                    child: const Text('อ่านบัตร'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _registeredUserCreateBloc.add(
                        CreateRegisteredUser(
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
                      _registeredUserCreateBloc.add(
                        InitialCreateRegisteredUser(),
                      );
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
                      _registeredUserCreateBloc.add(
                        InitialCreateRegisteredUser(),
                      );
                      context.read<RegisteredUserListBloc>().add(
                        GetRegisteredUserList(),
                      );
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

  List<Widget> _buildInputFields(RegisteredUserCreateState state) {
    return [
      SizedBox(
        height: 120,
        child: state.photoUrl.isNotEmpty
            ? Image.network(state.photoUrl, fit: BoxFit.cover)
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
                    kRegisteredUserTypeList.any((type) => type == state.type)
                    ? state.type
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
                  value: [DateTime.parse(state.expiredDate)],
                  borderRadius: BorderRadius.circular(15),
                );
                if (results != null) {
                  _registeredUserCreateBloc.add(SelectExpiredDate(results));
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
