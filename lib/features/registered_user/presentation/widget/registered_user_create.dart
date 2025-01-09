import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/constants.dart';
import 'package:carpark/features/registered_user/domain/models/create_registered_user_request.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_create/registered_user_create_bloc.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_list/registered_user_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class RegisteredUserCreate extends StatefulWidget {
  const RegisteredUserCreate({super.key});

  @override
  State<RegisteredUserCreate> createState() => _RegisteredUserCreateState();
}

class _RegisteredUserCreateState extends State<RegisteredUserCreate> {
  late RegisteredUserCreateBloc _bloc;

  final TextEditingController _idCardController = TextEditingController();
  final TextEditingController _thaiNameController = TextEditingController();
  final TextEditingController _engNameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressNameController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _bloc = context.read<RegisteredUserCreateBloc>();
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('อ่านบัตรสำเร็จ')),
          );
        case RegisteredUserCreateStatus.createSuccess:
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('สร้างผู้ใช้งานสำเร็จ')),
          );
          context.read<RegisteredUserListBloc>().add(GetRegisteredUserList());
        case RegisteredUserCreateStatus.savePhotoSuccess:
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('บันทึกภาพสำเร็จ')),
          );
        case RegisteredUserCreateStatus.readFailure:
        case RegisteredUserCreateStatus.createFailure:
        case RegisteredUserCreateStatus.savePhotoFailure:
        case RegisteredUserCreateStatus.failure:
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
      }
    }, builder: (context, state) {
      if (state.status == RegisteredUserCreateStatus.readSuccess) {
        _idCardController.text = state.idCard;
        _thaiNameController.text = state.thaiName;
        _engNameController.text = state.engName;
        _birthdateController.text = state.birthdate;
        _genderController.text = state.gender;
        _addressNameController.text = state.address;
      }

      final selectExpiredDate =
          'เลือกวันที่หมดอายุ : ${DateFormat("dd/MM/yyyy").format(state.expiredDate.isNotEmpty ? DateTime.parse(state.expiredDate) : DateTime.now())}';

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 120.0,
              child: state.photoUrl.isNotEmpty
                  ? Image.network(state.photoUrl, fit: BoxFit.cover)
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
                  value: [DateTime.parse(state.expiredDate)],
                  borderRadius: BorderRadius.circular(15),
                );
                if (results != null) {
                  _bloc.add(SelectExpiredDate(results));
                }
              },
              child: Text(
                selectExpiredDate,
                style: kButton2Style,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _bloc.add(ReadIdCard());
                    },
                    child: const Text('อ่านบัตร')),
                ElevatedButton(
                    onPressed: () {
                      _bloc.add(CreateRegisteredUser(
                        CreateRegisteredUserRequest(
                          idCard: _idCardController.text,
                          engName: _engNameController.text,
                          thaiName: _thaiNameController.text,
                          birthdate: _birthdateController.text,
                          gender: _genderController.text,
                          address: _addressNameController.text,
                          telephone: _telephoneController.text,
                          type: _typeController.text,
                          expiredDate: state.expiredDate,
                        ),
                      ));
                    },
                    child: const Text('ยืนยัน')),
                ElevatedButton(
                    onPressed: () {
                      _bloc.add(InitialCreateRegisteredUser());
                      _idCardController.clear();
                      _thaiNameController.clear();
                      _engNameController.clear();
                      _birthdateController.clear();
                      _genderController.clear();
                      _addressNameController.clear();
                      _telephoneController.clear();
                      _typeController.clear();
                    },
                    child: const Text('ล้างข้อมูล')),
                ElevatedButton(
                    onPressed: () {
                      _bloc.add(InitialCreateRegisteredUser());
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
