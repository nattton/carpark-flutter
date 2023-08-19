import 'package:carpark/components/vehicle_list_card.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/models/vehicle_model.dart';
import 'package:carpark/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_screen.g.dart';

@riverpod
MemberModel memberModel(MemberModelRef ref) {
  return MemberModel(id: 0, vehicles: []);
}

class MemberScreen extends ConsumerStatefulWidget {
  static const String id = "member_screen";

  const MemberScreen({super.key, required this.memberId});

  final int memberId;
  @override
  ConsumerState<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends ConsumerState<MemberScreen> {
  List<String> statusList = <String>['active', 'inactive', 'overdue'];

  final _nameController = TextEditingController();
  final _telController = TextEditingController();

  final _plateNumberController = TextEditingController();
  final _resembleController = TextEditingController();
  final _plateProvinceController = TextEditingController();
  final _brandController = TextEditingController();
  final _colorController = TextEditingController();
  final _telephoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getMember();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getMember() {
    final member = ref.read(memberModelProvider);
    sl<ApiService>()
        .getMember(sl<AppService>().token, widget.memberId)
        .then((value) {
      member.setMember(value);
      setState(() {
        _nameController.text = member.name!;
        _telController.text = member.telephone!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final member = ref.watch(memberModelProvider);
    return member.id != 0
        ? Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: _nameController,
                      onChanged: (value) {
                        member.name = value;
                      },
                      autofocus: false,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        suffixIcon: const Icon(Icons.account_circle),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: _telController,
                      onChanged: (value) {
                        member.telephone = value;
                      },
                      autofocus: false,
                      autocorrect: false,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Tel.',
                        suffixIcon: const Icon(Icons.phone),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    FormBuilderRadioGroup(
                      decoration: InputDecoration(
                        labelText: 'Type',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      initialValue: member.type,
                      name: 'type',
                      onChanged: (value) {
                        member.type = value;
                      },
                      validator: FormBuilderValidators.required(),
                      options: [
                        'residents',
                        'carrier',
                        'subcontractor',
                      ]
                          .map((lang) => FormBuilderFieldOption(value: lang))
                          .toList(growable: false),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    FormBuilderRadioGroup(
                      decoration: InputDecoration(
                        labelText: 'Status',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      initialValue: member.status,
                      name: 'status',
                      onChanged: (value) {
                        member.status = value;
                      },
                      validator: FormBuilderValidators.required(),
                      options: statusList
                          .map((lang) => FormBuilderFieldOption(value: lang))
                          .toList(growable: false),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                        onPressed: () => onPressedSave(),
                        child: const Text("บันทึกข้อมูล")),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                        onPressed: () => onPressedAdd(context),
                        child: const Text("สร้างทะเบียนรถ"))
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: member.vehicles!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return VehicleListCard(
                          vehicle: VehicleModel(id: 0),
                          onTap: () {},
                        );
                      }
                      return VehicleListCard(
                          vehicle: member.vehicles![index - 1],
                          onTap: () => onPressedEdit(
                              context, member.vehicles![index - 1]));
                    },
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  void onPressedAdd(BuildContext context) {
    _plateNumberController.text = '';
    _plateProvinceController.text = '';
    _brandController.text = '';
    _colorController.text = '';
    _telephoneController.text = '';

    Alert(
        context: context,
        title: "สร้างทะเบียนรถ",
        content: Column(
          children: [
            const SizedBox(height: 8.0),
            TextField(
              controller: _plateNumberController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'เลขทะเบียน',
                suffixIcon: const Icon(Icons.text_format),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _resembleController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'เลขทะเบียนที่คล้าย',
                suffixIcon: const Icon(Icons.text_format),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _plateProvinceController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'จังหวัด',
                suffixIcon: const Icon(Icons.text_fields),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _brandController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'ยี่ห้อ',
                suffixIcon: const Icon(Icons.text_fields),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _colorController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'สี',
                suffixIcon: const Icon(Icons.text_fields),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _telephoneController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'โทร.',
                suffixIcon: const Icon(Icons.phone),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              createVehicle();
            },
            child: const Text(
              "สร้าง",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void onPressedEdit(BuildContext context, VehicleModel vehicle) {
    _plateNumberController.text = vehicle.plateNumber!;
    _plateProvinceController.text = vehicle.plateProvince!;
    _brandController.text = vehicle.brand!;
    _colorController.text = vehicle.color!;
    _telephoneController.text = vehicle.telephone!;

    Alert(
        context: context,
        title: "แก้ไขทะเบียนรถ",
        content: Column(
          children: [
            const SizedBox(height: 8.0),
            TextField(
              controller: _plateNumberController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'เลขทะเบียน',
                suffixIcon: const Icon(Icons.text_format),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _resembleController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'เลขทะเบียนที่คล้าย',
                suffixIcon: const Icon(Icons.text_format),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _plateProvinceController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'จังหวัด',
                suffixIcon: const Icon(Icons.text_fields),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _brandController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'ยี่ห้อ',
                suffixIcon: const Icon(Icons.text_fields),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _colorController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'สี',
                suffixIcon: const Icon(Icons.text_fields),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _telephoneController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'โทร.',
                suffixIcon: const Icon(Icons.phone),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              updateVehicle(vehicle);
            },
            child: const Text(
              "บันทึก",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            color: Colors.red,
            onPressed: () {
              alertDelete(vehicle);
            },
            child: const Text(
              "ลบ",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void alertError(String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert Message'),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  void onPressedSave() {
    final member = ref.read(memberModelProvider);
    sl<ApiService>()
        .updateMember(sl<AppService>().token, widget.memberId, member)
        .then((value) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Save Member'),
          content: const Text('บันทึกข้อมูลเรียบร้อย'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }).catchError((error) {
      alertError(error);
    });
  }

  void createVehicle() {
    final vehicle = VehicleModel(
      memberId: widget.memberId,
      plateNumber: _plateNumberController.text,
      plateProvince: _plateProvinceController.text,
      brand: _brandController.text,
      color: _colorController.text,
      telephone: _telephoneController.text,
      resemble: _resembleController.text,
    );

    sl<ApiService>()
        .createVehicle(sl<AppService>().token, widget.memberId, vehicle)
        .then((value) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Create Vehicle'),
          content: const Text('เพิ่มข้อมูลทะเบียนเรียบร้อย'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                Navigator.pop(context);
                getMember();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }).catchError((error) {
      alertError(error);
    });
  }

  void updateVehicle(VehicleModel vehicle) {
    vehicle.memberId = widget.memberId;
    vehicle.plateNumber = _plateNumberController.text;
    vehicle.plateProvince = _plateProvinceController.text;
    vehicle.brand = _brandController.text;
    vehicle.color = _colorController.text;
    vehicle.telephone = _telephoneController.text;
    vehicle.resemble = _resembleController.text;

    sl<ApiService>()
        .updateVehicle(sl<AppService>().token, vehicle.id!, vehicle)
        .then((value) {
      getMember();
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Edit Vehicle'),
          content: const Text('แก้ไขข้อมูลทะเบียนเรียบร้อย'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }).onError((error, stack) {
      alertError(error.toString());
    });
  }

  void alertDelete(VehicleModel vehicle) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "ยืนยัน การลบทะเบียน",
      desc: "คุณต้องการลบทะเบียน : ${vehicle.plateNumber} ใช่หรือไม่",
      buttons: [
        DialogButton(
          color: Colors.red,
          onPressed: () {
            Navigator.pop(context);
            deleteVehicle(vehicle);
          },
          child: const Text(
            "ลบ",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "ไม่",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  void deleteVehicle(VehicleModel vehicle) {
    sl<ApiService>()
        .deleteVehicle(sl<AppService>().token, vehicle.id!)
        .then((value) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Edit Vehicle'),
          content: const Text('ลบข้อมูลทะเบียนเรียบร้อย'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                Navigator.pop(context);
                getMember();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }).catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioException:
          final res = (obj as DioException).response;
          alertError("Got error : ${res!.statusCode} -> ${res.statusMessage}");
          break;
        default:
          break;
      }
    });
  }
}
