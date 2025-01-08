import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/constants.dart';
import 'package:carpark/features/registered_user/domain/models/update_registered_user_request.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_list/registered_user_list_bloc.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_update/registered_user_update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class RegisteredUserUpdate extends StatefulWidget {
  const RegisteredUserUpdate({super.key});

  @override
  State<RegisteredUserUpdate> createState() => _RegisteredUserUpdateState();
}

class _RegisteredUserUpdateState extends State<RegisteredUserUpdate> {
  late RegisteredUserUpdateBloc _bloc;

  final TextEditingController _idCardController = TextEditingController();
  final TextEditingController _thaiNameController = TextEditingController();
  final TextEditingController _engNameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressNameController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  String _selectExpiredDate = '';

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
        case RegisteredUserUpdateStatus.updateFailure:
          return const SizedBox();
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
        _selectExpiredDate =
            'เลือกวันที่หมดอายุ : ${DateFormat("dd/MM/yyyy").format(state.registeredUser.expiredDate!.valid! ? state.registeredUser.expiredDate!.time! : DateTime.now())}';
      } else {
        _selectExpiredDate =
            'เลือกวันที่หมดอายุ : ${DateFormat("dd/MM/yyyy").format(DateTime.now())}';
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 120.0,
              child: state.registeredUser.photoUrl().isNotEmpty
                  ? Image.network(state.registeredUser.photoUrl(),
                      fit: BoxFit.cover)
                  : const Icon(size: 120.0, Icons.face),
            ),
            TextField(
              controller: _idCardController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'เลขประจำตัวประชาชน',
                suffixIcon: Icon(Icons.text_fields),
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
            ),
            TextField(
              controller: _thaiNameController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'ชื่อไทย',
                suffixIcon: Icon(Icons.text_fields),
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
            ),
            TextField(
              controller: _engNameController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'ชื่ออังกฤษ',
                suffixIcon: Icon(Icons.text_fields),
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: _birthdateController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'วันเกิด',
                suffixIcon: Icon(Icons.cake),
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
            ),
            TextField(
              controller: _genderController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'เพศ',
                suffixIcon: Icon(Icons.wc),
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
            ),
            TextField(
              controller: _addressNameController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                labelText: 'ที่อยู่',
                suffixIcon: Icon(Icons.location_city),
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: _telephoneController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'เบอร์โทรศัพท์',
                suffixIcon: Icon(Icons.phone),
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: _typeController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'ประเภท',
                suffixIcon: Icon(Icons.phone),
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16.0),
            OutlinedButton(
              onPressed: () async {
                var results = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(
                      calendarType: CalendarDatePicker2Type.single),
                  dialogSize: const Size(325, 400),
                  value: [
                    DateTime.parse(
                        state.registeredUser.expiredDate!.toDateString())
                  ],
                  borderRadius: BorderRadius.circular(15),
                );
                if (results != null) {
                  _bloc.add(UpdateRegisteredUserSelectExpiredDate(results));
                }
              },
              child: Text(
                _selectExpiredDate,
                style: kButton2Style,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
}
