import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpark/common/widgets/show_snackbar.dart';
import 'package:carpark/constants.dart';
import 'package:carpark/models/person_model.dart';
import 'package:carpark/models/update_person_model.dart';
import 'package:carpark/screens/people/bloc/person_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class PersonScreen extends StatefulWidget {
  static const String id = "person_screen";

  const PersonScreen({super.key, required this.personId});

  final String personId;
  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  final _idCardController = TextEditingController();
  final _thaiNameController = TextEditingController();
  final _engNameController = TextEditingController();
  final _telController = TextEditingController();
  final _addressController = TextEditingController();
  final _expiresAtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPerson();
  }

  @override
  void dispose() {
    _idCardController.dispose();
    _thaiNameController.dispose();
    _engNameController.dispose();
    _telController.dispose();
    _addressController.dispose();

    super.dispose();
  }

  void getPerson() {
    context.read<PersonBloc>().add(PersonEvent.get(widget.personId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ข้อมูลผู้ติดต่อ"),
      ),
      body: BlocConsumer<PersonBloc, PersonState>(
          listener: (context, state) {
            switch (state) {
              case UpdateSucess():
                showSnackBar(context, "บันทึกข้อมูลเรียบร้อย");
              case Error():
                showSnackBar(context, state.message);
              default:
            }
          },
          buildWhen: (previous, current) => current is Success,
          builder: (context, state) {
            if (state is Success) {
              return _body(state.person);
            }
            return const SizedBox();
          }),
    );
  }

  Widget _body(PersonModel person) {
    _idCardController.text = person.idCard;
    _thaiNameController.text = person.thaiName;
    _engNameController.text = person.engName;
    _telController.text = person.telephone;
    _addressController.text = person.address;

    if (_expiresAtController.text.isEmpty &&
        person.expiresAt != null &&
        person.expiresAt!.valid) {
      _expiresAtController.text =
          DateFormat('yyyy-MM-dd').format(person.expiresAt!.time);
    }

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
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _idCardController,
                  autofocus: false,
                  autocorrect: false,
                  readOnly: true,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'รหัสประจำตัวประชาชน',
                    suffixIcon: const Icon(Icons.card_membership),
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
                    labelText: 'เบอร์โทรศัพท์',
                    suffixIcon: const Icon(Icons.phone),
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _thaiNameController,
                  autofocus: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'ชื่อไทย',
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
                  controller: _engNameController,
                  autofocus: false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'English Name',
                    suffixIcon: const Icon(Icons.account_circle),
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
                  child: TextField(
                    controller: _addressController,
                    autofocus: false,
                    autocorrect: false,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      labelText: 'ที่อยู่',
                      suffixIcon: const Icon(Icons.home),
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderRadioGroup(
                    decoration: InputDecoration(
                      labelText: 'ประเภท',
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    initialValue: person.type,
                    name: 'type',
                    onChanged: (value) {
                      person = person.copyWith(type: value!);
                      context.read<PersonBloc>().add(Edit(person));
                    },
                    validator: FormBuilderValidators.required(),
                    options: kPeopleQueryTypeList
                        .map((lang) => FormBuilderFieldOption(value: lang))
                        .toList(growable: false),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _expiresAtController,
                    autofocus: false,
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'ผ่านประตูได้ถึงวันที่',
                      suffixIcon: GestureDetector(
                        child: const Icon(Icons.calendar_today),
                        onTap: () => openDatePicker(),
                      ),
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderRadioGroup(
                    decoration: InputDecoration(
                      labelText: 'สถานะ',
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    initialValue: person.isActive,
                    name: 'active',
                    onChanged: (value) {
                      person = person.copyWith(isActive: value!);
                      context.read<PersonBloc>().add(Edit(person));
                    },
                    validator: FormBuilderValidators.required(),
                    options: [true, false]
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
                    onPressed: () => onPressedSave(person),
                    child: const Text("บันทึกข้อมูล")),
              ),
            ),
          ],
        ),
        // const PersonHeaderCard(),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: member.vehicles!.length,
        //     itemBuilder: (context, index) {
        //       return PersonListCard(
        //           vehicle: member.vehicles![index],
        //           onTap: () => onPressedEdit(context, member.vehicles![index]));
        //     },
        //   ),
        // ),
      ],
    );
  }

  Future openDatePicker() async {
    DateTime expiresAt = DateTime.now();
    try {
      expiresAt = DateTime.parse(_expiresAtController.text);
    } catch (_) {}

    var results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
          calendarType: CalendarDatePicker2Type.single),
      dialogSize: const Size(325, 400),
      value: [expiresAt],
      borderRadius: BorderRadius.circular(15),
    );

    if (results != null) {
      setState(() {
        _expiresAtController.text =
            DateFormat('yyyy-MM-dd').format(results[0]!);
      });
    }
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

  void onPressedSave(PersonModel person) {
    var updatePerson = UpdatePersonModel(
      id: person.id,
      thaiName: _thaiNameController.text,
      engName: _engNameController.text,
      address: _addressController.text,
      telephone: _telController.text,
      type: person.type,
      expiresAt: _expiresAtController.text,
      isActive: person.isActive,
    );

    context.read<PersonBloc>().add(PersonEvent.update(updatePerson));
  }
}
