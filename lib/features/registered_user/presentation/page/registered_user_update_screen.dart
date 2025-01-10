import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/features/registered_user/domain/models/update_registered_user_request.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_list/registered_user_list_bloc.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_update/registered_user_update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisteredUserUpdateScreen extends StatefulWidget {
  const RegisteredUserUpdateScreen({super.key});

  @override
  State<RegisteredUserUpdateScreen> createState() =>
      _RegisteredUserUpdateScreenState();
}

class _RegisteredUserUpdateScreenState
    extends State<RegisteredUserUpdateScreen> {
  late RegisteredUserUpdateBloc _bloc;

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
    _bloc = context.read<RegisteredUserUpdateBloc>();
    return BlocConsumer<RegisteredUserUpdateBloc, RegisteredUserUpdateState>(
        listener: (context, state) {
      switch (state.status) {
        case RegisteredUserUpdateStatus.initial:
        case RegisteredUserUpdateStatus.selectingExpiredDate:
        case RegisteredUserUpdateStatus.selectExpiredDateSuccess:
          break;
        case RegisteredUserUpdateStatus.loading:
        case RegisteredUserUpdateStatus.updating:
          EasyLoading.show();
        case RegisteredUserUpdateStatus.loadSuccess:
          EasyLoading.dismiss();
        case RegisteredUserUpdateStatus.updateSuccess:
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('อัพเดทผู้ใช้งานสำเร็จ')),
          );
          context.read<RegisteredUserListBloc>().add(GetRegisteredUserList());
        case RegisteredUserUpdateStatus.loadFailure:
        case RegisteredUserUpdateStatus.updateFailure:
        case RegisteredUserUpdateStatus.failure:
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
      }
    }, builder: (context, state) {
      switch (state.status) {
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
          break;
      }

      if (state.status == RegisteredUserUpdateStatus.loadSuccess) {
        _idCardController.text = state.registeredUser.idCard;
        _thaiNameController.text = state.registeredUser.thaiName;
        _engNameController.text = state.registeredUser.engName;
        _birthdateController.text = state.registeredUser.birthdate;
        _genderController.text = state.registeredUser.gender;
        _addressNameController.text = state.registeredUser.address;
        _telephoneController.text = state.registeredUser.telephone;
        _typeController.text = state.registeredUser.type;
        _expiredDateController.text =
            state.registeredUser.expiredDate!.toDateString();
      }

      if (state.status == RegisteredUserUpdateStatus.selectExpiredDateSuccess) {
        _expiredDateController.text =
            state.registeredUser.expiredDate!.toDateString();
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ..._buildInputFields(state),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _bloc.add(UpdateRegisteredUser(
                        UpdateRegisteredUserRequest(
                          id: state.registeredUser.id,
                          idCard: _idCardController.text,
                          engName: _engNameController.text,
                          thaiName: _thaiNameController.text,
                          birthdate: _birthdateController.text,
                          gender: _genderController.text,
                          address: _addressNameController.text,
                          telephone: _telephoneController.text,
                          type: _typeController.text,
                          expiredDate:
                              state.registeredUser.expiredDate!.toDateString(),
                        ),
                      ));
                    },
                    child: const Text('ยืนยัน')),
                const SizedBox(width: 32.0),
                ElevatedButton(
                    onPressed: () {
                      context
                          .read<RegisteredUserListBloc>()
                          .add(GetRegisteredUserList());
                    },
                    child: const Text('ยกเลิก')),
              ],
            ),
          ],
        ),
      );
    });
  }

  List<Widget> _buildInputFields(RegisteredUserUpdateState state) {
    return [
      SizedBox(
        height: 120.0,
        child: state.registeredUser.photoUrl().isNotEmpty
            ? Image.network(state.registeredUser.photoUrl(), fit: BoxFit.cover)
            : const Icon(size: 120.0, Icons.face),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _idCardController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'เลขประจำตัวประชาชน',
                prefixIcon: Icon(Icons.text_fields),
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _birthdateController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'วันเกิด',
                prefixIcon: Icon(Icons.cake),
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
            ),
          ),
        ],
      ),
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          child: TextField(
            controller: _thaiNameController,
            autofocus: false,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: 'ชื่อไทย',
              prefixIcon: Icon(Icons.text_fields),
              contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            ),
          ),
        ),
        Expanded(
          child: TextField(
            controller: _engNameController,
            autofocus: false,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: 'ชื่ออังกฤษ',
              prefixIcon: Icon(Icons.text_fields),
              contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
      ]),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _telephoneController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'เบอร์โทรศัพท์',
                prefixIcon: Icon(Icons.phone),
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _genderController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'เพศ',
                prefixIcon: Icon(Icons.wc),
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
            ),
          ),
        ],
      ),
      TextField(
        controller: _addressNameController,
        autofocus: false,
        autocorrect: false,
        keyboardType: TextInputType.streetAddress,
        decoration: const InputDecoration(
          labelText: 'ที่อยู่',
          prefixIcon: Icon(Icons.location_city),
          contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        ),
        textInputAction: TextInputAction.next,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _typeController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'ประเภท',
                prefixIcon: Icon(Icons.group),
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                var results = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(
                      calendarType: CalendarDatePicker2Type.single),
                  dialogSize: const Size(325, 400),
                  value: [
                    state.registeredUser.expiredDate!.valid!
                        ? state.registeredUser.expiredDate!.time!
                        : DateTime.now()
                  ],
                  borderRadius: BorderRadius.circular(15),
                );
                if (results != null) {
                  _bloc.add(UpdateRegisteredUserSelectExpiredDate(results));
                }
              },
              child: TextField(
                onTap: () async {
                  var results = await showCalendarDatePicker2Dialog(
                    context: context,
                    config: CalendarDatePicker2WithActionButtonsConfig(
                        calendarType: CalendarDatePicker2Type.single),
                    dialogSize: const Size(325, 400),
                    value: [
                      state.registeredUser.expiredDate!.valid!
                          ? state.registeredUser.expiredDate!.time!
                          : DateTime.now()
                    ],
                    borderRadius: BorderRadius.circular(15),
                  );
                  if (results != null) {
                    _bloc.add(UpdateRegisteredUserSelectExpiredDate(results));
                  }
                },
                controller: _expiredDateController,
                autofocus: false,
                autocorrect: false,
                readOnly: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'วันหมดอายุ',
                  prefixIcon: GestureDetector(
                    child: Icon(Icons.group),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
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
