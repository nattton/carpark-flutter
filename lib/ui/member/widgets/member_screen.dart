import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:listen_it/listen_it.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../components/vehicle_header_card.dart';
import '../../../components/vehicle_list_card.dart';
import '../../../constants.dart';
import '../../../data/services/api/api_service.dart';
import '../../../data/services/api/model/vehicle/vehicle.dart';
import '../../../domain/models/member/member_model.dart';
import '../../../domain/models/member/vehicle_model.dart';
import '../../../injector/injector.dart';
import '../../../rounting/routes.dart';
import '../../../utils/result.dart';
import '../view_models/member_viewmodel.dart';

final memberModelProvider = StateProvider<MemberModel>(
  (ref) => MemberModel(id: 0, vehicles: []),
);

class MemberScreen extends StatefulWidget {
  const MemberScreen({
    super.key,
    required this.memberViewModel,
    required this.memberId,
  });

  final MemberViewModel memberViewModel;
  final int memberId;
  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  MemberViewModel get memberViewModel => widget.memberViewModel;

  ListenableSubscription? createMemberCommandSubscription;

  ListenableSubscription? getMemberCommandSubscription;
  ListenableSubscription? getMemberCommandErrorSubscription;

  ListenableSubscription? updateMemberCommandSubscription;
  ListenableSubscription? updateMemberCommandErrorSubscription;

  final _nameController = TextEditingController();
  final _telController = TextEditingController();
  final _typeFieldKey = GlobalKey<FormBuilderFieldState>();
  final _statusFieldKey = GlobalKey<FormBuilderFieldState>();

  final _plateNumberController = TextEditingController();
  final _resembleController = TextEditingController();
  final _plateProvinceController = TextEditingController();
  final _brandController = TextEditingController();
  final _colorController = TextEditingController();
  final _telephoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.memberId > 0) {
      memberViewModel.getMemberCommand.execute(widget.memberId);
    }
  }

  @override
  void didChangeDependencies() {
    getMemberCommandSubscription ??= memberViewModel.getMemberCommand.listen((
      event,
      state,
    ) {
      _nameController.text = event.name ?? '';
      _telController.text = event.telephone ?? '';
      _typeFieldKey.currentState?.didChange(event.type);
      _statusFieldKey.currentState?.didChange(event.status);
    });

    createMemberCommandSubscription ??= memberViewModel.createMemberCommand
        .listen((event, state) {
          switch (event) {
            case Ok<MemberModel>():
              GoRouter.of(context)
                ..pop()
                ..push(Routes.memberWithId(event.value.id));
            case Error<MemberModel>():
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('ไม่สามารถสร้างข้อมูลได้ ลองใหม่อีกครั้ง'),
                ),
              );
          }
        });

    getMemberCommandErrorSubscription ??= memberViewModel
        .getMemberCommand
        .errors
        .where((error) => error != null)
        .listen((event, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('ไม่สามารถดึงข้อมูลได้')));
          GoRouter.of(context).pop();
        });

    updateMemberCommandSubscription ??= memberViewModel.updateMemberCommand
        .listen((event, state) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย')));
          GoRouter.of(context).pop();
        });

    updateMemberCommandErrorSubscription ??= memberViewModel
        .updateMemberCommand
        .errors
        .where((error) => error != null)
        .listen((event, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('ไม่สามารถบันทึกข้อมูลได้ ลองใหม่อีกครั้ง')),
          );
        });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _telController.dispose();

    _plateNumberController.dispose();
    _resembleController.dispose();
    _plateProvinceController.dispose();
    _brandController.dispose();
    _colorController.dispose();
    _telephoneController.dispose();

    createMemberCommandSubscription?.cancel();
    getMemberCommandSubscription?.cancel();
    getMemberCommandErrorSubscription?.cancel();
    updateMemberCommandSubscription?.cancel();
    updateMemberCommandErrorSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: memberViewModel.getMemberCommand.isExecuting,
      builder: (context, isExecuting, _) {
        if (isExecuting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(title: const Text("แก้ไขข้อมูลสมาชิก")),
          body: Column(
            children: [
              const SizedBox(height: 10.0),
              ValueListenableBuilder(
                valueListenable: memberViewModel.getMemberCommand,
                builder: (context, member, _) {
                  return Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _nameController,
                              autofocus: false,
                              autocorrect: false,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                suffixIcon: const Icon(Icons.account_circle),
                                contentPadding: const EdgeInsets.all(20.0),
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
                              autofocus: false,
                              autocorrect: false,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Tel.',
                                suffixIcon: const Icon(Icons.phone),
                                contentPadding: const EdgeInsets.all(20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FormBuilderRadioGroup(
                              key: _typeFieldKey,
                              decoration: InputDecoration(
                                labelText: 'Type',
                                contentPadding: const EdgeInsets.all(20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              initialValue: member.type,
                              name: 'type',
                              validator: FormBuilderValidators.required(),
                              options: kMemberTypeList
                                  .map(
                                    (lang) =>
                                        FormBuilderFieldOption(value: lang),
                                  )
                                  .toList(growable: false),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FormBuilderRadioGroup(
                              key: _statusFieldKey,
                              decoration: InputDecoration(
                                labelText: 'Status',
                                contentPadding: const EdgeInsets.all(20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              initialValue: member.status,
                              name: 'status',
                              validator: FormBuilderValidators.required(),
                              options: kStatusList
                                  .map(
                                    (lang) =>
                                        FormBuilderFieldOption(value: lang),
                                  )
                                  .toList(growable: false),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              if (widget.memberId > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: _updateMember,
                          child: const Text("บันทึกข้อมูล"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Background color
                          ),
                          onPressed: () => onPressedAdd(context),
                          child: const Text("สร้างทะเบียนรถ"),
                        ),
                      ),
                    ),
                  ],
                ),
              if (widget.memberId == 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: _createMember,
                          child: const Text("สร้างข้อมูลสมาชิก"),
                        ),
                      ),
                    ),
                  ],
                ),
              const VehicleHeaderCard(),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: memberViewModel.getMemberCommand,
                  builder: (context, member, child) {
                    return ListView.builder(
                      itemCount: member.vehicles?.length ?? 0,
                      itemBuilder: (context, index) {
                        return VehicleListCard(
                          vehicle: member.vehicles![index],
                          onTap: () =>
                              onPressedEdit(context, member.vehicles![index]),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _createMember() {
    memberViewModel.createMemberCommand.execute(
      MemberModel(
        id: 0,
        name: _nameController.text,
        telephone: _telController.text,
        type: _typeFieldKey.currentState?.value,
        status: _statusFieldKey.currentState?.value,
        vehicles: [],
      ),
    );
  }

  void _updateMember() {
    memberViewModel.updateMemberCommand.execute(
      MemberModel(
        id: memberViewModel.getMemberCommand.value.id,
        name: _nameController.text,
        telephone: _telController.text,
        type: _typeFieldKey.currentState?.value,
        status: _statusFieldKey.currentState?.value,
      ),
    );
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
        ),
      ],
    ).show();
  }

  void onPressedEdit(BuildContext context, VehicleModel vehicle) {
    _plateNumberController.text = vehicle.plateNumber!;
    _resembleController.text = vehicle.resemble!;
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
        ),
      ],
    ).show();
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
                GoRouter.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void createVehicle() {
    final vehicle = CreateVehicleRequest(
      memberId: widget.memberId,
      plateNumber: _plateNumberController.text,
      plateProvince: _plateProvinceController.text,
      brand: _brandController.text,
      color: _colorController.text,
      telephone: _telephoneController.text,
      resemble: _resembleController.text,
    );

    getIt<ApiService>()
        .createVehicle(widget.memberId, vehicle)
        .then((value) {
          SnackBar(content: Text('เพิ่มข้อมูลทะเบียนเรียบร้อย'));
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Create Vehicle'),
              content: const Text('เพิ่มข้อมูลทะเบียนเรียบร้อย'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                    GoRouter.of(context).pop();
                    memberViewModel.getMemberCommand.execute(widget.memberId);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        })
        .catchError((error) {
          alertError(error);
        });
  }

  void updateVehicle(VehicleModel vehicle) {
    final updateVehicle = UpdateVehicleRequest(
      id: vehicle.id,
      memberId: widget.memberId,
      plateNumber: _plateNumberController.text,
      plateProvince: _plateProvinceController.text,
      brand: _brandController.text,
      color: _colorController.text,
      telephone: _telephoneController.text,
      resemble: _resembleController.text,
    );

    getIt<ApiService>()
        .updateVehicle(vehicle.id!, updateVehicle)
        .then((value) {
          if (context.mounted) {
            context.pop();
            memberViewModel.getMemberCommand.execute(widget.memberId);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('แก้ไขข้อมูลทะเบียนเรียบร้อย')),
            );
          }
        })
        .onError((error, stack) {
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
            GoRouter.of(context).pop();
            deleteVehicle(vehicle);
          },
          child: const Text(
            "ลบ",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => GoRouter.of(context).pop(),
          child: const Text(
            "ไม่",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  void deleteVehicle(VehicleModel vehicle) {
    getIt<ApiService>()
        .deleteVehicle(vehicle.id!)
        .then((value) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Edit Vehicle'),
              content: const Text('ลบข้อมูลทะเบียนเรียบร้อย'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                    GoRouter.of(context).pop();
                    memberViewModel.getMemberCommand.execute(widget.memberId);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        })
        .catchError((Object obj) {
          // non-200 error goes here.
          switch (obj.runtimeType) {
            case DioException _:
              final res = (obj as DioException).response;
              alertError(
                "Got error : ${res!.statusCode} -> ${res.statusMessage}",
              );
              break;
            default:
              break;
          }
        });
  }
}
