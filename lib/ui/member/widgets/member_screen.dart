import 'package:carpark/config/constants.dart';
import 'package:carpark/domain/models/member/member_model.dart';
import 'package:carpark/domain/models/member/vehicle_model.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/rounting/routes.dart';
import 'package:carpark/ui/member/view_models/member_viewmodel.dart';
import 'package:carpark/ui/member/widgets/vehicle_header_card.dart';
import 'package:carpark/ui/member/widgets/vehicle_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MemberScreen extends WatchingStatefulWidget {
  const MemberScreen({
    required this.memberId,
    super.key,
  });

  final int memberId;
  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  MemberViewModel get _memberViewModel => getIt<MemberViewModel>();

  final _nameController = TextEditingController();
  final _telController = TextEditingController();
  final _typeFieldKey =
      GlobalKey<FormBuilderFieldState<FormBuilderRadioGroup<String>, String>>();
  final _statusFieldKey =
      GlobalKey<FormBuilderFieldState<FormBuilderRadioGroup<String>, String>>();

  final _plateNumberController = TextEditingController();
  final _resembleController = TextEditingController();
  final _plateProvinceController = TextEditingController();
  final _brandController = TextEditingController();
  final _colorController = TextEditingController();
  final _telephoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _memberViewModel.getMemberCommand.run(widget.memberId);
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

    super.dispose();
  }

  void _registerHandler() {
    registerHandler(
      select: (MemberViewModel viewModel) => viewModel.createMemberCommand,
      handler: (context, value, cancel) async {
        context.pop();
        await context.push(Routes.memberWithId(value.id));
      },
    );

    registerHandler(
      select: (MemberViewModel viewModel) =>
          viewModel.createMemberCommand.errors,
      handler: (context, error, cancel) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'ไม่สามารถสร้างข้อมูลได้ ลองใหม่อีกครั้ง',
            ),
          ),
        );
      },
    );

    registerHandler(
      select: (MemberViewModel viewModel) => viewModel.getMemberCommand,
      handler: (context, value, cancel) {
        _nameController.text = value.name ?? '';
        _telController.text = value.telephone ?? '';
        _typeFieldKey.currentState?.didChange(value.type);
        _statusFieldKey.currentState?.didChange(value.status);
      },
    );

    registerHandler(
      select: (MemberViewModel viewModel) => viewModel.getMemberCommand.errors,
      handler: (context, error, cancel) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          const SnackBar(content: Text('ไม่สามารถดึงข้อมูลได้')),
        );
        GoRouter.of(context).pop();
      },
    );

    registerHandler(
      select: (MemberViewModel viweModel) => viweModel.updateMemberCommand,
      handler: (context, value, cancel) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          const SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย')),
        );
        _memberViewModel.getMemberCommand.run(widget.memberId);
      },
    );

    registerHandler(
      select: (MemberViewModel viweModel) =>
          viweModel.updateMemberCommand.errors,
      handler: (context, error, cancel) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ไม่สามารถบันทึกข้อมูลได้ ลองใหม่อีกครั้ง'),
          ),
        );
      },
    );

    registerHandler(
      select: (MemberViewModel viweModel) => viweModel.createVehicleCommand,
      handler: (context, value, cancel) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          const SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย')),
        );
        GoRouter.of(context).pop();
        _memberViewModel.getMemberCommand.run(widget.memberId);
      },
    );

    registerHandler(
      select: (MemberViewModel viweModel) =>
          viweModel.createVehicleCommand.errors,
      handler: (context, error, cancel) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ไม่สามารถบันทึกข้อมูลได้ ลองใหม่อีกครั้ง'),
          ),
        );
      },
    );

    registerHandler(
      select: (MemberViewModel viweModel) => viweModel.updateVehicleCommand,
      handler: (context, value, cancel) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          const SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย')),
        );
        GoRouter.of(context).pop();
        _memberViewModel.getMemberCommand.run(widget.memberId);
      },
    );

    registerHandler(
      select: (MemberViewModel viweModel) =>
          viweModel.updateVehicleCommand.errors,
      handler: (context, error, cancel) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ไม่สามารถบันทึกข้อมูลได้ ลองใหม่อีกครั้ง'),
          ),
        );
      },
    );

    registerHandler(
      select: (MemberViewModel viweModel) => viweModel.deleteVehicleCommand,
      handler: (context, value, cancel) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('ลบข้อมูลเรียบร้อย')));
        GoRouter.of(context).pop();
        _memberViewModel.getMemberCommand.run(widget.memberId);
      },
    );

    registerHandler(
      select: (MemberViewModel viweModel) =>
          viweModel.deleteVehicleCommand.errors,
      handler: (context, error, cancel) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ไม่สามารถลบข้อมูลได้ ลองใหม่อีกครั้ง'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _registerHandler();

    final isRunning = watchValue(
      (MemberViewModel viewModel) => viewModel.getMemberCommand.isRunning,
    );

    final member = watchValue(
      (MemberViewModel viewModel) => viewModel.member,
    );

    if (isRunning) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('แก้ไขข้อมูลสมาชิก')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: _nameController,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        suffixIcon: const Icon(Icons.account_circle),
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: _telController,
                      autocorrect: false,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Tel.',
                        suffixIcon: const Icon(Icons.phone),
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: FormBuilderRadioGroup<String>(
                      key: _typeFieldKey,
                      decoration: InputDecoration(
                        labelText: 'Type',
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      initialValue: member.type,
                      name: 'type',
                      validator: FormBuilderValidators.required<String>(),
                      options: kMemberTypeList
                          .map(
                            (lang) => FormBuilderFieldOption(value: lang),
                          )
                          .toList(growable: false),
                      onChanged: (value) {
                        _memberViewModel.member.value = _memberViewModel
                            .member
                            .value
                            .copyWith(type: value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: FormBuilderRadioGroup<String>(
                      key: _statusFieldKey,
                      decoration: InputDecoration(
                        labelText: 'Status',
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      initialValue: member.status,
                      name: 'status',
                      validator: FormBuilderValidators.required<String>(),
                      options: kStatusList
                          .map(
                            (lang) => FormBuilderFieldOption(value: lang),
                          )
                          .toList(growable: false),
                      onChanged: (value) {
                        _memberViewModel.member.value = _memberViewModel
                            .member
                            .value
                            .copyWith(status: value);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (member.id > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: _updateMember,
                      child: const Text('บันทึกข้อมูล'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Background color
                      ),
                      onPressed: () => onPressedAdd(context),
                      child: const Text('สร้างทะเบียนรถ'),
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
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: _createMember,
                      child: const Text('สร้างข้อมูลสมาชิก'),
                    ),
                  ),
                ),
              ],
            ),
          const VehicleHeaderCard(),
          Expanded(
            child: ListView.builder(
              itemCount: member.vehicles?.length ?? 0,
              itemBuilder: (context, index) {
                return VehicleListCard(
                  vehicle: member.vehicles![index],
                  onTap: () => onPressedEdit(context, member.vehicles![index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _createMember() {
    _memberViewModel.createMemberCommand.run(
      MemberModel(
        id: 0,
        name: _nameController.text,
        telephone: _telController.text,
        type: _memberViewModel.member.value.type,
        status: _memberViewModel.member.value.status,
        vehicles: [],
      ),
    );
  }

  void _updateMember() {
    _memberViewModel.updateMemberCommand.run(
      MemberModel(
        id: _memberViewModel.member.value.id,
        name: _nameController.text,
        telephone: _telController.text,
        type: _memberViewModel.member.value.type,
        status: _memberViewModel.member.value.status,
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
      title: 'สร้างทะเบียนรถ',
      content: Column(
        children: [
          const SizedBox(height: 8),
          TextField(
            controller: _plateNumberController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'เลขทะเบียน',
              suffixIcon: const Icon(Icons.text_format),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _resembleController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'เลขทะเบียนที่คล้าย',
              suffixIcon: const Icon(Icons.text_format),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _plateProvinceController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'จังหวัด',
              suffixIcon: const Icon(Icons.text_fields),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _brandController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'ยี่ห้อ',
              suffixIcon: const Icon(Icons.text_fields),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _colorController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'สี',
              suffixIcon: const Icon(Icons.text_fields),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _telephoneController,
            autocorrect: false,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'โทร.',
              suffixIcon: const Icon(Icons.phone),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: createVehicle,
          child: const Text(
            'สร้าง',
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
      title: 'แก้ไขทะเบียนรถ',
      content: Column(
        children: [
          const SizedBox(height: 8),
          TextField(
            controller: _plateNumberController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'เลขทะเบียน',
              suffixIcon: const Icon(Icons.text_format),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _resembleController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'เลขทะเบียนที่คล้าย',
              suffixIcon: const Icon(Icons.text_format),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _plateProvinceController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'จังหวัด',
              suffixIcon: const Icon(Icons.text_fields),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _brandController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'ยี่ห้อ',
              suffixIcon: const Icon(Icons.text_fields),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _colorController,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'สี',
              suffixIcon: const Icon(Icons.text_fields),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _telephoneController,
            autocorrect: false,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'โทร.',
              suffixIcon: const Icon(Icons.phone),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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
            'บันทึก',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          color: Colors.red,
          onPressed: () {
            alertDelete(vehicle);
          },
          child: const Text(
            'ลบ',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  void alertError(String msg) {
    showDialog<Widget>(
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
    final vehicle = VehicleModel(
      memberId: widget.memberId,
      plateNumber: _plateNumberController.text,
      plateProvince: _plateProvinceController.text,
      brand: _brandController.text,
      color: _colorController.text,
      telephone: _telephoneController.text,
      resemble: _resembleController.text,
    );

    _memberViewModel.createVehicleCommand.run(vehicle);
  }

  void updateVehicle(VehicleModel vehicle) {
    final updateVehicle = VehicleModel(
      id: vehicle.id,
      memberId: widget.memberId,
      plateNumber: _plateNumberController.text,
      plateProvince: _plateProvinceController.text,
      brand: _brandController.text,
      color: _colorController.text,
      telephone: _telephoneController.text,
      resemble: _resembleController.text,
    );

    _memberViewModel.updateVehicleCommand.run(updateVehicle);
  }

  void alertDelete(VehicleModel vehicle) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: 'ยืนยัน การลบทะเบียน',
      desc: 'คุณต้องการลบทะเบียน : ${vehicle.plateNumber} ใช่หรือไม่',
      buttons: [
        DialogButton(
          color: Colors.red,
          onPressed: () {
            GoRouter.of(context).pop();
            deleteVehicle(vehicle);
          },
          child: const Text(
            'ลบ',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => GoRouter.of(context).pop(),
          child: const Text(
            'ไม่',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  void deleteVehicle(VehicleModel vehicle) {
    _memberViewModel.deleteVehicleCommand.run(vehicle.id);
  }
}
