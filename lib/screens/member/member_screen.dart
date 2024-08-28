import 'package:carpark/common/widgets/show_snackbar.dart';
import 'package:carpark/components/vehicle_header_card.dart';
import 'package:carpark/components/vehicle_list_card.dart';
import 'package:carpark/constants.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/models/vehicle_model.dart';
import 'package:carpark/screens/member/bloc/member_bloc.dart';
import 'package:carpark/screens/member/bloc/vehicle_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MemberScreen extends StatefulWidget {
  static const String id = "member_screen";

  const MemberScreen({super.key, required this.memberId});

  final int memberId;
  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  final _nameController = TextEditingController();
  final _telController = TextEditingController();
  String? _status;
  String? _type;

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

  void getMember() {
    context.read<MemberBloc>().add(MemberEvent.getMember(widget.memberId));
  }

  void _memberListener(BuildContext context, MemberState state) {
    switch (state) {
      case UpdateSuccess():
        showSnackBar(context, "Update member success.");
        getMember();
      case Error():
        showSnackBar(context, state.message);
      default:
    }
  }

  void _vehicleListener(BuildContext context, VehicleState state) {
    switch (state) {
      case CreateVehicleSuccess():
        showSnackBar(context, "Create vehicle success.");
        getMember();
      case UpdateVehicleSuccess():
        showSnackBar(context, "Update vehicle success.");
        getMember();
      case DeleteVehicleSuccess():
        showSnackBar(context, "Delete vehicle success.");
        getMember();
      case ErrorVehicle():
        showSnackBar(context, state.message);
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("แก้ไขข้อมูลสมาชิก"),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<VehicleBloc, VehicleState>(listener: _vehicleListener),
            BlocListener<MemberBloc, MemberState>(listener: _memberListener),
          ],
          child: BlocBuilder<MemberBloc, MemberState>(
            buildWhen: (previous, current) {
              return current is Success;
            },
            builder: (context, state) {
              if (state is Success) {
                return _body(state.member);
              }
              return Container();
            },
          ),
        ));
  }

  Widget _body(MemberModel member) {
    _nameController.text = member.name!;
    _telController.text = member.telephone!;
    _status = member.status;
    _type = member.type;
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(),
            1: FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(children: <Widget>[
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
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
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
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ]),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderRadioGroup(
                    decoration: InputDecoration(
                      labelText: 'Type',
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    initialValue: _type,
                    name: 'type',
                    onChanged: (value) {
                      _type = value;
                    },
                    validator: FormBuilderValidators.required(),
                    options: kMemberTypeList
                        .map((lang) => FormBuilderFieldOption(value: lang))
                        .toList(growable: false),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderRadioGroup(
                    decoration: InputDecoration(
                      labelText: 'Status',
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    initialValue: _status,
                    name: 'status',
                    onChanged: (value) {
                      _status = value;
                    },
                    validator: FormBuilderValidators.required(),
                    options: kStatusList
                        .map((lang) => FormBuilderFieldOption(value: lang))
                        .toList(growable: false),
                  ),
                ),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ElevatedButton(
                    onPressed: () => onPressedSave(),
                    child: const Text("บันทึกข้อมูล")),
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
                    child: const Text("สร้างทะเบียนรถ")),
              ),
            ),
          ],
        ),
        const VehicleHeaderCard(),
        Expanded(
          child: ListView.builder(
            itemCount: member.vehicles!.length,
            itemBuilder: (context, index) {
              return VehicleListCard(
                  vehicle: member.vehicles![index],
                  onTap: () => onPressedEdit(context, member.vehicles![index]));
            },
          ),
        ),
      ],
    );
  }

  void onPressedAdd(BuildContext context) {
    _plateNumberController.text = '';
    _resembleController.text = '';
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
            _textDialog(_plateNumberController, TextInputType.name,
                'เลขทะเบียน', const Icon(Icons.text_format)),
            const SizedBox(height: 8.0),
            _textDialog(_resembleController, TextInputType.name,
                'เลขทะเบียนที่คล้าย', const Icon(Icons.text_format)),
            const SizedBox(height: 8.0),
            _textDialog(_plateProvinceController, TextInputType.name, 'จังหวัด',
                const Icon(Icons.text_fields)),
            const SizedBox(height: 8.0),
            _textDialog(_brandController, TextInputType.name, 'ยี่ห้อ',
                const Icon(Icons.text_format)),
            const SizedBox(height: 8.0),
            _textDialog(_colorController, TextInputType.name, 'สี',
                const Icon(Icons.text_format)),
            const SizedBox(height: 8.0),
            _textDialog(_telephoneController, TextInputType.phone, 'โทร',
                const Icon(Icons.phone)),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => createVehicle(),
            child: const Text(
              "สร้าง",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
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
            _textDialog(_plateNumberController, TextInputType.name,
                'เลขทะเบียน', const Icon(Icons.text_format)),
            const SizedBox(height: 8.0),
            _textDialog(_resembleController, TextInputType.name,
                'เลขทะเบียนที่คล้าย', const Icon(Icons.text_format)),
            const SizedBox(height: 8.0),
            _textDialog(_plateProvinceController, TextInputType.name, 'จังหวัด',
                const Icon(Icons.text_fields)),
            const SizedBox(height: 8.0),
            _textDialog(_brandController, TextInputType.name, 'ยี่ห้อ',
                const Icon(Icons.text_format)),
            const SizedBox(height: 8.0),
            _textDialog(_colorController, TextInputType.name, 'สี',
                const Icon(Icons.text_format)),
            const SizedBox(height: 8.0),
            _textDialog(_telephoneController, TextInputType.phone, 'โทร',
                const Icon(Icons.phone)),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => updateVehicle(vehicle),
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

  void showSuccess(String title, String content) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void onPressedSave() {
    var member = MemberModel(
        id: widget.memberId,
        name: _nameController.text,
        telephone: _telController.text,
        type: _type,
        status: _status,
        vehicles: []);

    context.read<MemberBloc>().add(MemberEvent.updateMember(member));
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
    context.read<VehicleBloc>().add(VehicleEvent.createVehicle(vehicle));
    Navigator.pop(context);
  }

  void updateVehicle(VehicleModel vehicle) {
    vehicle.memberId = widget.memberId;
    vehicle.plateNumber = _plateNumberController.text;
    vehicle.plateProvince = _plateProvinceController.text;
    vehicle.brand = _brandController.text;
    vehicle.color = _colorController.text;
    vehicle.telephone = _telephoneController.text;
    vehicle.resemble = _resembleController.text;

    context.read<VehicleBloc>().add(VehicleEvent.updateVehicle(vehicle));
    Navigator.pop(context);
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
    context.read<VehicleBloc>().add(VehicleEvent.deleteVehicle(vehicle));
    Navigator.pop(context);
  }

  Widget _textDialog(
    TextEditingController controller,
    TextInputType inputType,
    String labelText,
    Icon icon,
  ) {
    return TextField(
      controller: controller,
      autofocus: false,
      autocorrect: false,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: icon,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
