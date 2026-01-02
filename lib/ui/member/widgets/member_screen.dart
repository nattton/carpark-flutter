import 'package:carpark/config/constants.dart';
import 'package:carpark/domain/models/member/member_model.dart';
import 'package:carpark/domain/models/member/vehicle_model.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/rounting/routes.dart';
import 'package:carpark/ui/member/view_models/member_viewmodel.dart';
import 'package:carpark/ui/member/widgets/vehicle_form_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    // 1. One-time initialization
    callOnce((_) => _memberViewModel.getMemberCommand.run(widget.memberId));

    // 2. Register handlers
    _registerHandler();

    // 3. Watch reactive state
    final isRunning = watchValue(
      (MemberViewModel viewModel) => viewModel.getMemberCommand.isRunning,
    );

    final member = watchValue(
      (MemberViewModel viewModel) => viewModel.member,
    );

    // 4. Build UI
    if (isRunning) return const Center(child: CircularProgressIndicator());

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
                    child: TextFormField(
                      initialValue: member.name,
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
                      onChanged: (value) {
                        _memberViewModel.member.value = _memberViewModel
                            .member
                            .value
                            .copyWith(name: value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      initialValue: member.telephone,
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
                      onChanged: (value) {
                        _memberViewModel.member.value = _memberViewModel
                            .member
                            .value
                            .copyWith(telephone: value);
                      },
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: FormBuilderRadioGroup<String>(
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
                      onPressed: () => _memberViewModel.newVehicleCommand.run(),
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
                  onTap: () => _memberViewModel.editVehicleCommand.run(
                    member.vehicles![index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
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
      handler: _onCreateError,
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
      handler: _onUpdateError,
    );

    registerHandler(
      select: (MemberViewModel viweModel) => viweModel.newVehicleCommand,
      handler: (context, _, _) async {
        await Alert(
          context: context,
          title: 'สร้างทะเบียนรถ',
          content: const VehicleFormWidget(),
          buttons: [
            DialogButton(
              onPressed: _memberViewModel.createVehicleCommand.run,
              child: const Text(
                'สร้าง',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ).show();
      },
    );

    registerHandler(
      select: (MemberViewModel viweModel) => viweModel.editVehicleCommand,
      handler: (context, _, _) async {
        await Alert(
          context: context,
          title: 'แก้ไขทะเบียนรถ',
          content: const VehicleFormWidget(),
          buttons: [
            DialogButton(
              onPressed: _memberViewModel.updateVehicleCommand.run,
              child: const Text(
                'บันทึก',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            DialogButton(
              color: Colors.red,
              onPressed: alertDelete,
              child: const Text(
                'ลบ',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ).show();
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
      },
    );

    registerHandler(
      select: (MemberViewModel viweModel) =>
          viweModel.createVehicleCommand.errors,
      handler: _onCreateError,
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
      },
    );

    registerHandler(
      select: (MemberViewModel viweModel) =>
          viweModel.updateVehicleCommand.errors,
      handler: _onUpdateError,
    );

    registerHandler(
      select: (MemberViewModel viweModel) => viweModel.deleteVehicleCommand,
      handler: (context, value, cancel) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('ลบข้อมูลเรียบร้อย')));
        GoRouter.of(context).pop();
      },
    );

    registerHandler(
      select: (MemberViewModel viweModel) =>
          viweModel.deleteVehicleCommand.errors,
      handler: _onDeleteError,
    );
  }

  void _onCreateError(
    BuildContext context,
    dynamic error,
    void Function() cancel,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'ไม่สามารถสร้างข้อมูลได้ ลองใหม่อีกครั้ง',
        ),
      ),
    );
  }

  void _onUpdateError(
    BuildContext context,
    dynamic error,
    void Function() cancel,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'ไม่สามารถบันทึกข้อมูลได้ ลองใหม่อีกครั้ง',
        ),
      ),
    );
  }

  void _onDeleteError(
    BuildContext context,
    CommandError<int>? error,
    void Function() cancel,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ไม่สามารถลบข้อมูลได้ ลองใหม่อีกครั้ง'),
      ),
    );
  }

  void _createMember() {
    _memberViewModel.createMemberCommand.run(
      MemberModel(
        id: 0,
        name: _memberViewModel.member.value.name,
        telephone: _memberViewModel.member.value.telephone,
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
        name: _memberViewModel.member.value.name,
        telephone: _memberViewModel.member.value.telephone,
        type: _memberViewModel.member.value.type,
        status: _memberViewModel.member.value.status,
      ),
    );
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

  Future<void> alertDelete() async {
    final vehicle = _memberViewModel.vehicleEditing.value;
    if (vehicle == null) return;
    await Alert(
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
