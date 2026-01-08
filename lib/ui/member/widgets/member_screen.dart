import 'package:carpark/config/constants.dart';
import 'package:carpark/data/repositories/member/member_repository.dart';
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

class MemberScreen extends WatchingWidget {
  const MemberScreen({
    required this.memberId,
    super.key,
  });

  final int memberId;

  @override
  Widget build(BuildContext context) {
    pushScope(
      init: (di) => di.registerSingleton<MemberViewModel>(
        MemberViewModel(memberRepository: getIt<MemberRepository>()),
      ),
    );
    // 1. One-time initialization
    callOnce((_) {
      getIt<MemberViewModel>().getMemberCommand.run(memberId);
    });

    // 2. Register handlers
    _registerHandler();

    // 3. Watch reactive state
    final isRunning = watchValue(
      (MemberViewModel viewModel) => viewModel.getMemberCommand.isRunning,
    );

    final memberIdCommand = watchValue(
      (MemberViewModel viewModel) => viewModel.memberIdCommand,
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
            children: const <TableRow>[
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: MemberNameFieldWidget(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: MemberTelephoneFieldWidget(),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: MemberTypeRadioWidget(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: MemberStatusRadioWidget(),
                  ),
                ],
              ),
            ],
          ),
          if (memberIdCommand > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: ElevatedButton(
                      onPressed:
                          getIt<MemberViewModel>().updateMemberCommand.run,
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
                      onPressed: getIt<MemberViewModel>().newVehicleCommand.run,
                      child: const Text('สร้างทะเบียนรถ'),
                    ),
                  ),
                ),
              ],
            ),
          if (memberIdCommand == 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: ElevatedButton(
                      onPressed:
                          getIt<MemberViewModel>().createMemberCommand.run,
                      child: const Text('สร้างข้อมูลสมาชิก'),
                    ),
                  ),
                ),
              ],
            ),
          const VehicleHeaderCard(),
          const Expanded(
            child: VehiclesListViewWidget(),
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
        context.pop();
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
        getIt<MemberViewModel>().getMemberCommand.run(memberId);
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
              onPressed: getIt<MemberViewModel>().createVehicleCommand.run,
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
              onPressed: getIt<MemberViewModel>().updateVehicleCommand.run,
              child: const Text(
                'บันทึก',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            DialogButton(
              color: Colors.red,
              onPressed: () => alertDelete(context),
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
        context.pop();
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
        context.pop();
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

  Future<void> alertDelete(BuildContext context) async {
    final vehicle = getIt<MemberViewModel>().vehicleEditing.value;
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
            getIt<MemberViewModel>().deleteVehicleCommand.run(vehicle.id);
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
}

class MemberNameFieldWidget extends WatchingWidget {
  const MemberNameFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final name = watchValue(
      (MemberViewModel viewModel) => viewModel.nameCommand,
    );
    return TextFormField(
      initialValue: name,
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
        getIt<MemberViewModel>().nameCommand(value);
      },
    );
  }
}

class MemberTelephoneFieldWidget extends WatchingWidget {
  const MemberTelephoneFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final telephone = watchValue(
      (MemberViewModel viewModel) => viewModel.telephoneCommand,
    );
    return TextFormField(
      initialValue: telephone,
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
        getIt<MemberViewModel>().telephoneCommand(value);
      },
    );
  }
}

class MemberTypeRadioWidget extends WatchingWidget {
  const MemberTypeRadioWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final memberType = watchValue(
      (MemberViewModel viewModel) => viewModel.typeCommand,
    );
    return FormBuilderRadioGroup<String>(
      decoration: InputDecoration(
        labelText: 'Type',
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      initialValue: memberType,
      name: 'type',
      validator: FormBuilderValidators.required<String>(),
      options: kMemberTypeList
          .map(
            (lang) => FormBuilderFieldOption(value: lang),
          )
          .toList(growable: false),
      onChanged: (value) => getIt<MemberViewModel>().typeCommand(value),
    );
  }
}

class MemberStatusRadioWidget extends WatchingWidget {
  const MemberStatusRadioWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final status = watchValue(
      (MemberViewModel viewModel) => viewModel.statusCommand,
    );
    return FormBuilderRadioGroup<String>(
      decoration: InputDecoration(
        labelText: 'Status',
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      initialValue: status,
      name: 'status',
      validator: FormBuilderValidators.required<String>(),
      options: kStatusList
          .map(
            (lang) => FormBuilderFieldOption(value: lang),
          )
          .toList(growable: false),
      onChanged: (value) => getIt<MemberViewModel>().statusCommand(value),
    );
  }
}

class VehiclesListViewWidget extends WatchingWidget {
  const VehiclesListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vehicles = watchValue(
      (MemberViewModel viewModel) => viewModel.vehiclesCommand,
    );
    return ListView.builder(
      itemCount: vehicles.length,
      itemBuilder: (context, index) {
        return VehicleListCard(
          vehicle: vehicles[index],
          onTap: () => getIt<MemberViewModel>().editVehicleCommand.run(
            vehicles[index],
          ),
        );
      },
    );
  }
}
