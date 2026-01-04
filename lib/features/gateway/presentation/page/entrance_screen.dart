import 'dart:async';
import 'dart:io';

import 'package:carpark/config/constants.dart';
import 'package:carpark/data/repositories/printer/printer_repository.dart';
import 'package:carpark/data/services/api/api_service.dart';
import 'package:carpark/domain/models/member/member_model.dart';
import 'package:carpark/domain/models/registered_user/registered_user.dart';
import 'package:carpark/features/gateway/domain/entity/id_card_entity.dart';
import 'package:carpark/features/gateway/domain/repository/id_card_service_repository.dart';
import 'package:carpark/features/gateway/presentation/widget/entrance_card.dart';
import 'package:carpark/features/gateway/presentation/widget/exit_card.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/models/gate_log_model.dart';
import 'package:carpark/models/visitor_model.dart';
import 'package:carpark/rounting/routes.dart';
import 'package:carpark/ui/home/view_models/late_gate_viewmodel.dart';
import 'package:carpark/ui/live_player/view_models/live_player_viewmodel.dart';
import 'package:carpark/ui/live_player/widgets/card_player_widget.dart';
import 'package:carpark/ui/live_player/widgets/live_player_widget.dart';
import 'package:carpark/ui/member/bloc/member_list/member_list_bloc.dart';
import 'package:carpark/ui/registered_user/bloc/registered_user_check_in/registered_user_check_in_bloc.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:thermal_printer/thermal_printer.dart';

enum EntranceScreenLeftState { initial, visitor, checkIn }

class EntranceScreen extends WatchingStatefulWidget {
  const EntranceScreen({super.key});

  @override
  State<EntranceScreen> createState() => _EntranceScreenState();

  static Widget get page => MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => getIt<RegisteredUserCheckInBloc>()),
    ],
    child: const EntranceScreen(),
  );
}

class _EntranceScreenState extends State<EntranceScreen> {
  final _log = Logger('EntranceScreen');

  PrinterRepository get _printerRepository => context.read<PrinterRepository>();

  late RegisteredUserCheckInBloc _registeredUserCheckInBloc;
  late FocusNode focusNode;

  EntranceScreenLeftState _leftState = EntranceScreenLeftState.initial;
  bool _isReadDrivingLicence = false;
  bool _isReadCard = false;
  String _vehicleType = 'car';

  IDCardEntity? _idCardModel;
  File? _photoFile;
  int _selectedGateLogId = 0;

  MemberModel? _selectedMember;
  TextEditingController _memberController = TextEditingController();

  final _drivingLicenceController = TextEditingController();

  final _plateNumberController = TextEditingController();
  final _idCardController = TextEditingController();
  final _thaiNameController = TextEditingController();
  final _engNameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _genderController = TextEditingController();
  final _addressNameController = TextEditingController();
  final _barcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MemberListBloc>().add(LoadMemberList());
    _registeredUserCheckInBloc = context.read<RegisteredUserCheckInBloc>();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    _plateNumberController.dispose();
    _idCardController.dispose();
    _thaiNameController.dispose();
    _engNameController.dispose();
    _birthdateController.dispose();
    _genderController.dispose();
    _addressNameController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gateLogIn = watchValue(
      (LastGateViewmodel viewModel) => viewModel.gateIn,
    );

    return BlocListener<RegisteredUserCheckInBloc, RegisteredUserCheckInState>(
      listener: (context, state) {
        if (state is RegisteredUserCheckInSuccess) {
          alertCheckIn(state.registeredUser);
        } else if (state is RegisteredUserCheckInFailure) {
          alertError(state.failure.message);
        }
      },
      child: gateLogIn.id != 0
          ? Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                top: 8,
                                right: 8,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _barcodeController,
                                      autofocus: true,
                                      autocorrect: false,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: _onBarcodeSubmitted,
                                          child: const Icon(
                                            Icons.barcode_reader,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.all(
                                          8,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            0,
                                          ),
                                        ),
                                      ),
                                      onSubmitted: (value) =>
                                          _onBarcodeSubmitted(),
                                      focusNode: focusNode,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child:
                                        _leftState ==
                                            EntranceScreenLeftState.visitor
                                        ? ElevatedButton(
                                            onPressed: openVisitior,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors
                                                  .red, // Background color
                                            ),
                                            child: const Text(
                                              'ยกเลิก',
                                              style: kButtonStyle,
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: showVisitorFromEmpty,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  kColorButtonPrimary,
                                            ),
                                            child: const Text(
                                              'สร้างผู้ติดต่อ',
                                              style: kButtonStyle,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        switch (_leftState) {
                          EntranceScreenLeftState.visitor =>
                            _buildVisitorForm(),
                          EntranceScreenLeftState.checkIn =>
                            _buildCheckInForm(),
                          _ => _buildViewer(),
                        },
                      ],
                    ),
                  ),
                  const Expanded(
                    child: !kIsWeb
                        ? LivePlayerWidget()
                        : Column(
                            children: [ExitCard()],
                          ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  void _onBarcodeSubmitted() {
    final barcode = _barcodeController.text;
    _barcodeController.clear();
    focusNode.requestFocus();
    _registeredUserCheckInBloc.add(
      PostRegisteredUserCheckInEvent(generatedId: barcode),
    );
  }

  Widget _buildViewer() {
    final gateLogIn = getIt<LastGateViewmodel>().gateIn.value;
    return EntranceCard(
      gateLog: gateLogIn,
      onTapSelectGateLog: () => showVisitorFromSelect(gateLogIn),
    );
  }

  Widget _buildCheckInForm() {
    return BlocBuilder<RegisteredUserCheckInBloc, RegisteredUserCheckInState>(
      builder: (context, state) {
        switch (state) {
          case RegisteredUserCheckInInitial():
            return const SizedBox();
          case RegisteredUserCheckInLoading():
            return const Center(child: CircularProgressIndicator());
          case RegisteredUserCheckInSuccess():
            return const SizedBox();
          case RegisteredUserCheckInFailure():
            return Center(child: Text(state.failure.message));
        }
      },
    );
  }

  Widget _buildVisitorForm() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(child: Text('ประเภท', style: kGateStyle)),
                ),
                Expanded(
                  child: FormBuilderRadioGroup(
                    initialValue: _vehicleType,
                    name: 'type',
                    onChanged: (value) {
                      _vehicleType = value!;
                    },
                    validator: FormBuilderValidators.required<String>(),
                    options: kVehicleTypeMap.entries
                        .map(
                          (e) => FormBuilderFieldOption(
                            value: e.key,
                            child: Text(e.value),
                          ),
                        )
                        .toList(growable: false),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _plateNumberController,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        labelText: 'เลขทะเบียน',
                        suffixIcon: const Icon(Icons.directions_car),
                        contentPadding: const EdgeInsets.all(8),
                      ),
                    ),
                  ),
                  Expanded(child: _buildSearchMember()),
                ],
              ),
            ),

            Container(
              height: 60,
              color: Colors.white10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: readSmartCardFromService,
                    child: const Text('อ่านบัตรปชช.', style: kButtonStyle),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 161, 80, 175),
                    ),
                    onPressed: inputDrivingLicence,
                    child: const Text('อ่านใบขับขี่', style: kButtonStyle),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: clearForm,
                    child: const Text('ล้างข้อมูล', style: kButtonStyle),
                  ),
                  ElevatedButton(
                    onPressed: saveAndPrint,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kColorButtonPrimary,
                    ),
                    child: const Text('บันทึกและพิมพ์', style: kButtonStyle),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isReadDrivingLicence,
              child: TextField(
                controller: _drivingLicenceController,
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                minLines: 7,
                maxLines: 7,
                decoration: const InputDecoration(
                  labelText: 'ข้อมูลใบขับขี่',
                  contentPadding: EdgeInsets.all(8),
                ),
                onChanged: readDrivingLicence,
                focusNode: focusNode,
              ),
            ),
            Visibility(
              visible: _isReadCard,
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                },
                children: [
                  TableRow(
                    children: <Widget>[
                      SizedBox(
                        height: 120,
                        child: _photoFile != null
                            ? Image.file(_photoFile!)
                            : const Icon(size: 120, Icons.face),
                      ),
                      TextField(
                        controller: _idCardController,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'เลขประจำตัวประชาชน',
                          suffixIcon: Icon(Icons.text_fields),
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TextField(
                        controller: _thaiNameController,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'ชื่อไทย',
                          suffixIcon: Icon(Icons.text_fields),
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                      TextField(
                        controller: _engNameController,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'ชื่ออังกฤษ',
                          suffixIcon: Icon(Icons.text_fields),
                          contentPadding: EdgeInsets.all(8),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TextField(
                        controller: _birthdateController,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'วันเกิด',
                          suffixIcon: Icon(Icons.cake),
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                      TextField(
                        controller: _genderController,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'เพศ',
                          suffixIcon: Icon(Icons.wc),
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TextField(
                        controller: _addressNameController,
                        autocorrect: false,
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                          labelText: 'ที่อยู่',
                          suffixIcon: Icon(Icons.location_city),
                          contentPadding: EdgeInsets.all(8),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      Container(),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !_isReadDrivingLicence && !_isReadCard,
              child: const CardPlayerWidget(),
            ),
          ],
        ),
      ),
    );
  }

  void showVisitorFromSelect(GateLogModel gateLog) {
    _selectedMember = null;
    _plateNumberController.text = gateLog.plateNumber!;
    _selectedGateLogId = gateLog.id;
    if (gateLog.memberId != 0 && gateLog.member!.status == 'overdue') {
      _selectedMember = gateLog.member;
    }

    openVisitior();
  }

  void showVisitorFromEmpty() {
    _selectedMember = null;
    _plateNumberController.clear();
    _selectedGateLogId = 0;
    openVisitior();
  }

  Future<void> openVisitior() async {
    setState(() {
      clearForm();
      _vehicleType = 'car';

      _leftState = _leftState == EntranceScreenLeftState.initial
          ? EntranceScreenLeftState.visitor
          : EntranceScreenLeftState.initial;

      _isReadCard = false;
      _isReadDrivingLicence = false;
    });
  }

  Future<void> manualCapture(String door) async {
    await getIt<ApiService>().manualCapture(door).then((value) {}).onError((
      error,
      stackTrace,
    ) {
      alertError(error.toString());
    });
  }

  void clearForm() {
    _drivingLicenceController.clear();
    _idCardModel = null;
    _photoFile = null;
    _idCardController.clear();
    _thaiNameController.clear();
    _engNameController.clear();
    _birthdateController.clear();
    _genderController.clear();
    _addressNameController.clear();
    setState(() {});
  }

  Future<void> inputDrivingLicence() async {
    focusNode.requestFocus();
    clearForm();
    _drivingLicenceController.text = '';
    _isReadDrivingLicence = true;
    _isReadCard = false;
  }

  void readDrivingLicence(String value) {
    final count = '\n'.allMatches(value).length;
    _log.info('count: $count');
    if (count == 6) {
      final lines = value.split('\n');

      final name = lines[0];
      final idNumber = lines[2];
      final licenceNumber = lines[4];

      _log
        ..info('Name : $name')
        ..info('idNumber : $idNumber')
        ..info('licenceNumber : $licenceNumber');

      final nameList = name.split(r'$').reversed.toList();
      for (var i = 0; i < nameList.length; i++) {
        nameList[i] = nameList[i].replaceAll('\n', ' ');
        _log.info(nameList[i]);
      }
      final nameEng = nameList.join(' ');
      _log.info('NameEng : $nameEng');
    }
  }

  Future<void> readSmartCardFromService() async {
    clearForm();
    await EasyLoading.show();
    _isReadDrivingLicence = false;
    _isReadCard = true;
    final card = await getIt<IdCardServiceRepository>().readIdCard();
    await card.fold(
      (l) {
        alertError(l.message);
        EasyLoading.dismiss();
      },
      (r) async {
        _idCardModel = r.data;
        _photoFile = await _tempImage(r.data!.id);
        await getIt<Dio>().download(_idCardModel!.photoUrl(), _photoFile!.path);
        _idCardController.text = r.data!.id;
        _thaiNameController.text = r.data!.thaiName;
        _engNameController.text = r.data!.engName;
        _birthdateController.text = r.data!.birthdate;
        _genderController.text = r.data!.genderName();
        _addressNameController.text = r.data!.address;
        await EasyLoading.dismiss();
        setState(() {});
      },
    );
  }

  Future<Uint8List> charsetConvert(String s) async {
    return CharsetConverter.encode('windows-874', s);
  }

  Future<List<int>> _generateTicket(VisitorModel visitor) async {
    final gateLogIn = getIt<LastGateViewmodel>().gateIn.value;
    var bytes = <int>[];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile, spaceBetweenRows: 8);
    bytes += generator.setGlobalCodeTable('CP874');

    // Print image:
    final data = await rootBundle.load('images/logo.png');
    final imgBytes = data.buffer.asUint8List();
    final image = img.decodeImage(imgBytes)!;
    bytes += generator.image(image);

    bytes += generator.qrcode(visitor.dateTimeNanoShortFormat());

    if (kVehicleTypeMap.containsKey(visitor.type)) {
      final vehicleType = kVehicleTypeMap[visitor.type];
      bytes += generator.textEncoded(
        await charsetConvert('ประเภท : $vehicleType'),
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      );
    }
    bytes += generator.textEncoded(
      await charsetConvert('ทะเบียนรถ : ${visitor.plateNumber!}'),
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );

    bytes += generator.textEncoded(
      await charsetConvert('วันที่ : ${gateLogIn.dateFormat()}'),
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );
    bytes += generator.textEncoded(
      await charsetConvert('เวลา : ${gateLogIn.timeFormat()}'),
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );

    bytes += generator.textEncoded(
      await charsetConvert('เวลาออก _______________'),
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
      linesAfter: 1,
    );

    if (_selectedMember != null) {
      bytes += generator.textEncoded(
        await charsetConvert('ติดต่อ : ${_selectedMember?.name}'),
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1,
      );
    } else {
      bytes += generator.textEncoded(
        await charsetConvert('ติดต่อ _______________'),
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1,
      );
    }

    final dataFrame = await rootBundle.load('images/frame_stamp.png');
    final imgFrameBytes = dataFrame.buffer.asUint8List();
    final imageFrame = img.decodeImage(imgFrameBytes)!;
    bytes += generator.image(imageFrame);

    if (visitor.member!.status! == 'overdue') {
      bytes += generator.textEncoded(
        await charsetConvert('*$kOverdueText $kOverdue2Text*'),
        styles: const PosStyles(
          bold: true,
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 2,
      );
    }

    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
  }

  Future<File> _tempImage(String type) async {
    final directory = await getTemporaryDirectory();

    return File('${directory.path}/$type.jpg');
  }

  Future<void> saveAndPrint() async {
    if (_selectedMember == null) {
      alertError('เลือกบ้านที่ติดต่อ');
      return;
    }

    final visitor = VisitorModel(
      0,
      type: _vehicleType,
      plateNumber: _plateNumberController.text,
      memberId: _selectedMember?.id,
      gateLogId: _selectedGateLogId,
      idCard: _idCardController.text.replaceAll(' ', ''),
      thaiName: _thaiNameController.text,
      engName: _engNameController.text,
      birthdate: _birthdateController.text,
      gender: _genderController.text,
      address: _addressNameController.text,
      visitorImages: [],
    );

    await getIt<ApiService>()
        .createVisitor(visitor)
        .then((value) async {
          if (value.idCard != '') {
            await addPhotoToVisitor(value);
          }
          await addImageToVisitor(value);
          await printTicket(value);
          setState(() {
            _leftState = EntranceScreenLeftState.initial;
            _isReadCard = false;
          });
        })
        .onError((error, stackTrace) {
          alertError(error.toString());
        });
  }

  Future<void> addPhotoToVisitor(VisitorModel visitor) async {
    if (_idCardModel != null && _photoFile != null) {
      if (await _photoFile!.exists()) {
        await getIt<ApiService>()
            .addPhotoVisitor(visitor.id, _photoFile!)
            .then((value) => {});
      }
    }
  }

  Future<void> addImageToVisitor(VisitorModel visitor) async {
    final cameraPlayer = getIt<LivePlayerViewmodel>();
    final cardImage = await _tempImage('card');
    final inSideImage = await _tempImage('in_side');
    final entranceImage = await _tempImage('entrance');

    final cardScreenshot = await cameraPlayer.cardPlayer.screenshot();
    final sideScreenshot = await cameraPlayer.sidePlayer.screenshot();
    final mainScreenshot = await cameraPlayer.mainPlayer.screenshot();

    if (cardScreenshot != null) {
      await cardImage.writeAsBytes(cardScreenshot);
    }
    if (sideScreenshot != null) {
      await inSideImage.writeAsBytes(sideScreenshot);
    }
    if (mainScreenshot != null) {
      await entranceImage.writeAsBytes(mainScreenshot);
    }

    if (await cardImage.exists()) {
      await getIt<ApiService>().addImageToVisitor(
        visitor.id,
        'card',
        cardImage,
      );
      cardImage.delete();
    }
    if (await inSideImage.exists()) {
      await getIt<ApiService>().addImageToVisitor(
        visitor.id,
        'in_side',
        inSideImage,
      );
      inSideImage.delete();
    }
    if (await entranceImage.exists()) {
      await getIt<ApiService>().addImageToVisitor(
        visitor.id,
        'entrance',
        entranceImage,
      );
      entranceImage.delete();
    }
  }

  Future<void> printTicket(VisitorModel visitor) async {
    final printerManager = PrinterManager.instance;
    await printerManager.connect(
      type: PrinterType.usb,
      model: UsbPrinterInput(
        name: await _printerRepository.printerName,
      ),
    );
    await printerManager.send(
      type: PrinterType.usb,
      bytes: await _generateTicket(visitor),
    );
    await printerManager.disconnect(type: PrinterType.usb);
  }

  Widget _buildSearchMember() {
    final members = context.read<MemberListBloc>().state.members;
    return Autocomplete<MemberModel>(
      initialValue:
          _selectedMember != null && _selectedMember!.status == 'overdue'
          ? TextEditingValue(text: _selectedMember!.name!)
          : null,
      displayStringForOption: (MemberModel member) {
        return member.name!;
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable.empty();
        }
        return members.where(
          (MemberModel member) => member.name!.contains(textEditingValue.text),
        );
      },
      onSelected: (MemberModel member) {
        _selectedMember = member;
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Material(
          elevation: 4,
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final option = options.elementAt(index);
              return ListTile(
                title: SubstringHighlight(
                  text: option.name!,
                  term: _memberController.text,
                  textStyleHighlight: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  option.vehicles != null
                      ? option.vehicles!
                            .map((vehicle) => vehicle.plateNumber!)
                            .join(', ')
                      : '',
                ),
                onTap: () {
                  onSelected(option);
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: options.length,
          ),
        );
      },
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        _memberController = controller;

        return TextField(
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            labelText: 'ติดต่อ',
            prefixIcon: const Icon(Icons.search),
          ),
        );
      },
    );
  }

  void alertMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void alertError(String msg) {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error Message'),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void alertCheckIn(RegisteredUser registeredUser) {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Check In'),
          content: Text('ลงเวลาเข้าโดย ${registeredUser.thaiName}'),
          actions: [
            TextButton(
              onPressed: () {
                context
                  ..pop()
                  ..push(
                    Routes.registeredUserLogsWithId(registeredUser.id),
                  );
              },
              child: const Text('ดูประวัติการเข้าใช้งาน'),
            ),
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('ปิด'),
            ),
          ],
        );
      },
    );
  }
}
