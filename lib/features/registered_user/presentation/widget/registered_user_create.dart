import 'dart:io';

import 'package:carpark/features/registered_user/presentation/bloc/registered_user_create/registered_user_create_bloc.dart';
import 'package:carpark/features/registered_user/presentation/bloc/registered_user_list/registered_user_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisteredUserCreate extends StatefulWidget {
  const RegisteredUserCreate({super.key});

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisteredUserCreateBloc, RegisteredUserCreateState>(
        builder: (context, state) {
      if (state.status == RegisteredUserCreateStatus.readSuccess) {
        _idCardController.text = state.id;
        _thaiNameController.text = state.thaiName;
        _engNameController.text = state.engName;
        _birthdateController.text = state.birthdate;
        _genderController.text = state.gender;
        _addressNameController.text = state.address;
      }

      return Column(
        children: <Widget>[
          SizedBox(
            height: 120.0,
            child: state.photoPath.isNotEmpty
                ? Image.file(File(state.photoPath))
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
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<RegisteredUserCreateBloc>()
                        .add(ReadSmartCard());
                  },
                  child: const Text('อ่านบัตร')),
              ElevatedButton(onPressed: () {}, child: const Text('ยืนยัน')),
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
      );
    });
  }
}
