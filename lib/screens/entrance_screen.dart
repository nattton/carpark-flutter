import 'dart:async';
import 'dart:io';

import 'package:carpark/components/entrance_card.dart';
import 'package:carpark/components/exit_card.dart';
import 'package:carpark/components/live_player_section.dart';
import 'package:carpark/constants.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/gate_log_model.dart';
import 'package:carpark/models/id_card_model.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/models/response_model.dart';
import 'package:carpark/models/visitor_model.dart';
import 'package:carpark/screens/main_screen.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:media_kit_video/media_kit_video.dart';
import 'package:path_provider/path_provider.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:thermal_printer/thermal_printer.dart';

class EntranceScreen extends StatefulHookConsumerWidget {
  const EntranceScreen({super.key});

  @override
  ConsumerState<EntranceScreen> createState() => _EntranceScreenState();
}

class _EntranceScreenState extends ConsumerState<EntranceScreen> {
  late FocusNode focusNode;

  bool _isShowVisitor = false;
  bool _isReadDrivingLicence = false;
  bool _isReadCard = false;
  String _vehicleType = 'car';

  IDCardModel? _idCardModel;
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

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gateLog = ref.watch(lastGateProvider).gateIn;
    final gateLogOut = ref.watch(lastGateProvider).gateOut;
    final player = ref.watch(cameraPlayerProvider);
    return gateLog.id != 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      !kIsWeb
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () => openDoor("in"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kColorButtonPrimary),
                                  child: const Text(
                                    "เปิดประตู ขาเข้า",
                                    style: kButtonStyle,
                                  ),
                                ),
                                // ElevatedButton(
                                //   onPressed: () => openDoor("in"),
                                //   style: ElevatedButton.styleFrom(
                                //       backgroundColor: Colors.lightGreen),
                                //   child: const Text(
                                //     "อ่านป้ายทะเบียนอีกครั้ง",
                                //     style: kButtonStyle,
                                //   ),
                                // ),
                                _isShowVisitor
                                    ? ElevatedButton(
                                        onPressed: () => openVisitior(),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.red, // Background color
                                        ),
                                        child: const Text(
                                          "ยกเลิก",
                                          style: kButtonStyle,
                                        ),
                                      )
                                    : ElevatedButton(
                                        onPressed: () => showVisitorFromEmpty(),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                kColorButtonPrimary),
                                        child: const Text(
                                          "สร้างผู้ติดต่อ",
                                          style: kButtonStyle,
                                        ),
                                      ),
                              ],
                            )
                          : const SizedBox(),
                      _isShowVisitor ? _buildVisitorForm() : _buildViewer(),
                    ],
                  ),
                ),
                Expanded(
                  child: !kIsWeb
                      ? LivePlayerSection(
                          mainController: player.mainController,
                          sideController: player.sideController)
                      : Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [ExitCard(gateLog: gateLogOut)],
                        ),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _buildViewer() {
    final gateLog = ref.watch(lastGateProvider).gateIn;
    return EntranceCard(
        gateLog: gateLog,
        onTapSelectGateLog: () => showVisitorFromSelect(gateLog));
  }

  Widget _buildVisitorForm() {
    final player = ref.watch(cameraPlayerProvider);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(6.0),
        child: Column(children: [
          Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  Container(
                    height: 60.0,
                    color: Colors.indigo[300],
                    child: const Center(
                      child: Text(
                        "ประเภท",
                        style: kGateStyle,
                      ),
                    ),
                  ),
                  FormBuilderRadioGroup(
                      initialValue: _vehicleType,
                      name: 'type',
                      onChanged: (value) {
                        _vehicleType = value!;
                      },
                      validator: FormBuilderValidators.required(),
                      options: kVehicleTypeMap.entries
                          .map((e) => FormBuilderFieldOption(
                                value: e.key,
                                child: Text(e.value),
                              ))
                          .toList(growable: false)),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Container(
                    height: 54,
                    color: Colors.indigo[300],
                    child: const Center(
                      child: Text(
                        "เลขทะเบียน",
                        style: kGateStyle,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _plateNumberController,
                    autofocus: false,
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.directions_car),
                      contentPadding:
                          const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    height: 54,
                    color: Colors.indigo[300],
                    child: const Center(
                      child: Text(
                        "ติดต่อ",
                        style: kGateStyle,
                      ),
                    ),
                  ),
                  _buildSearchMember(),
                ],
              ),
            ],
          ),
          Container(
            height: 60,
            color: Colors.white10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => readSmartCardFromService(),
                  child: const Text(
                    "อ่านบัตรปชช.",
                    style: kButtonStyle,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 161, 80, 175)),
                  onPressed: () => inputDrivingLicence(),
                  child: const Text(
                    "อ่านใบขับขี่",
                    style: kButtonStyle,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => clearForm(),
                  child: const Text(
                    "ล้างข้อมูล",
                    style: kButtonStyle,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => saveAndPrint(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kColorButtonPrimary),
                  child: const Text(
                    "บันทึกและพิมพ์",
                    style: kButtonStyle,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _isReadDrivingLicence,
            child: TextField(
              controller: _drivingLicenceController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.multiline,
              minLines: 7,
              maxLines: 7,
              decoration: const InputDecoration(
                labelText: 'ข้อมูลใบขับขี่',
                contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
              onChanged: (value) => readDrivingLicence(value),
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
                        height: 120.0,
                        child: _photoFile != null
                            ? Image.file(_photoFile!)
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
                          contentPadding:
                              EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TextField(
                        controller: _thaiNameController,
                        autofocus: false,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'ชื่อไทย',
                          suffixIcon: Icon(Icons.text_fields),
                          contentPadding:
                              EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
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
                          contentPadding:
                              EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TextField(
                        controller: _birthdateController,
                        autofocus: false,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'วันเกิด',
                          suffixIcon: Icon(Icons.cake),
                          contentPadding:
                              EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
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
                          contentPadding:
                              EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      TextField(
                        controller: _addressNameController,
                        autofocus: false,
                        autocorrect: false,
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                          labelText: 'ที่อยู่',
                          suffixIcon: Icon(Icons.location_city),
                          contentPadding:
                              EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      Container(),
                    ],
                  ),
                ],
              )),
          Visibility(
            visible: !_isReadDrivingLicence && !_isReadCard,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 60,
              height:
                  ((MediaQuery.of(context).size.width / 2 - 60) * 9.0 / 16.0),
              child: Video(
                controller: player.cardController,
                controls: null,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void showVisitorFromSelect(GateLogModel gateLog) {
    _selectedMember = null;
    _plateNumberController.text = gateLog.plateNumber!;
    _selectedGateLogId = gateLog.id;
    if (gateLog.memberId != 0 && gateLog.member!.status == "overdue") {
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

  Future openVisitior() async {
    setState(() {
      clearForm();
      _vehicleType = "car";
      _isShowVisitor = !_isShowVisitor;
      _isReadCard = false;
      _isReadDrivingLicence = false;
    });
  }

  Future<void> openDoor(String door) async {
    sl<ApiService>()
        .openDoor(sl<AppService>().token, door)
        .then((value) {})
        .onError((error, stackTrace) {
      alertError(error.toString());
    });
  }

  Future<void> manualCapture(String door) async {
    sl<ApiService>()
        .manualCapture(sl<AppService>().token, door)
        .then((value) {})
        .onError((error, stackTrace) {
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

  void inputDrivingLicence() async {
    focusNode.requestFocus();
    clearForm();
    _drivingLicenceController.text = "";
    _isReadDrivingLicence = true;
    _isReadCard = false;
  }

  void readDrivingLicence(String value) {
    int count = '\n'.allMatches(value).length;
    print('count: $count');
    if (count == 6) {
      final lines = value.split("\n");
      // for (var i = 0; i < lines.length; i++) {
      //   print(" $i = ${lines[i]} ");
      // }

      final name = lines[0];
      final idNumber = lines[2];
      final licenceNumber = lines[4];

      print("Name : $name");
      print("idNumber : $idNumber");
      print("licenceNumber : $licenceNumber");

      var nameList = name.split("\$").reversed.toList();
      for (var i = 0; i < nameList.length; i++) {
        nameList[i] = nameList[i].replaceAll("\n", " ");
        print(nameList[i]);
      }
      final nameEng = nameList.join(" ");
      print("NameEng : $nameEng");
    }
  }

  void readSmartCardFromService() async {
    clearForm();
    EasyLoading.show();
    _isReadDrivingLicence = false;
    _isReadCard = true;
    sl<ApiService>().smartCardReader().then((card) async {
      _idCardModel = card;
      _photoFile = await _tempImage(card.id);
      await sl<Dio>().download(_idCardModel!.photoUrl(), _photoFile!.path);
      _idCardController.text = card.id;
      _thaiNameController.text = card.thaiName;
      _engNameController.text = card.engName;
      _birthdateController.text = card.birthdate;
      _genderController.text = card.genderName();
      _addressNameController.text = card.address;
      EasyLoading.dismiss();
      setState(() {});
    }).catchError((Object obj) {
      EasyLoading.dismiss();
      switch (obj.runtimeType) {
        case DioException:
          final res = (obj as DioException).response;
          final response = ResponseModel.fromJson(res!.data);
          alertError(response.error);
          break;
        default:
          break;
      }
    });
  }

  Future<Uint8List> charsetConvert(String s) async {
    return await CharsetConverter.encode("windows-874", s);
  }

  Future<List<int>> _generateTicket(VisitorModel visitor) async {
    final gateLog = ref.watch(lastGateProvider).gateIn;
    List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(
      PaperSize.mm80,
      profile,
      spaceBetweenRows: 8,
    );
    bytes += generator.setGlobalCodeTable('CP874');

    // Print image:
    final ByteData data = await rootBundle.load('images/logo.png');
    final Uint8List imgBytes = data.buffer.asUint8List();
    final image = img.decodeImage(imgBytes)!;
    bytes += generator.image(image);

    bytes += generator.qrcode(visitor.dateTimeNanoShortFormat());

    if (kVehicleTypeMap.containsKey(visitor.type)) {
      var vehicleType = kVehicleTypeMap[visitor.type];
      bytes +=
          generator.textEncoded(await charsetConvert("ประเภท : $vehicleType"),
              styles: const PosStyles(
                align: PosAlign.left,
                height: PosTextSize.size2,
                width: PosTextSize.size2,
              ));
    }
    bytes += generator.textEncoded(
        await charsetConvert("ทะเบียนรถ : ${visitor.plateNumber!}"),
        styles: const PosStyles(
          align: PosAlign.left,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    bytes += generator.textEncoded(
        await charsetConvert("วันที่ : ${gateLog.dateFormat()}"),
        styles: const PosStyles(
          align: PosAlign.left,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));
    bytes += generator.textEncoded(
        await charsetConvert("เวลา : ${gateLog.timeFormat()}"),
        styles: const PosStyles(
          align: PosAlign.left,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    bytes += generator.textEncoded(
      await charsetConvert('เวลาออก _______________'),
      styles: const PosStyles(
        align: PosAlign.left,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
      linesAfter: 1,
    );

    if (_selectedMember != null) {
      bytes += generator.textEncoded(
        await charsetConvert("ติดต่อ : ${_selectedMember?.name}"),
        styles: const PosStyles(
          align: PosAlign.left,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1,
      );
    } else {
      bytes += generator.textEncoded(
        await charsetConvert('ติดต่อ _______________'),
        styles: const PosStyles(
          align: PosAlign.left,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1,
      );
    }

    final ByteData dataFrame = await rootBundle.load('images/frame_stamp.png');
    final Uint8List imgFrameBytes = dataFrame.buffer.asUint8List();
    final imageFrame = img.decodeImage(imgFrameBytes)!;
    bytes += generator.image(imageFrame);

    if (visitor.member!.status! == "overdue") {
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

  void saveAndPrint() async {
    if (_selectedMember == null) {
      alertError("เลือกบ้านที่ติดต่อ");
      return;
    }

    var visitor = VisitorModel(0,
        type: _vehicleType,
        plateNumber: _plateNumberController.text,
        memberId: _selectedMember?.id,
        gateLogId: _selectedGateLogId,
        idCard: _idCardController.text.replaceAll(" ", ""),
        thaiName: _thaiNameController.text,
        engName: _engNameController.text,
        birthdate: _birthdateController.text,
        gender: _genderController.text,
        address: _addressNameController.text,
        visitorImages: []);

    sl<ApiService>()
        .createVisitor(sl<AppService>().token, visitor)
        .then((value) async {
      if (value.idCard != "") {
        addPhotoToVisitor(value);
      }
      addImageToVisitor(value);
      printTicket(value);
      setState(() {
        _isShowVisitor = false;
        _isReadCard = false;
      });
    }).onError((error, stackTrace) {
      alertError(error.toString());
    });
  }

  void addPhotoToVisitor(VisitorModel visitor) async {
    if (_idCardModel != null && _photoFile != null) {
      if (await _photoFile!.exists()) {
        sl<ApiService>()
            .addPhotoVisitor(sl<AppService>().token, visitor.id, _photoFile!)
            .then((value) => {});
      }
    }
  }

  void addImageToVisitor(VisitorModel visitor) async {
    final cameraPlayer = ref.watch(cameraPlayerProvider);
    File cardImage = await _tempImage("card");
    File inSideImage = await _tempImage("in_side");
    File entranceImage = await _tempImage("entrance");

    final Uint8List? cardScreenshot =
        await cameraPlayer.cardPlayer.screenshot();
    final Uint8List? sideScreenshot =
        await cameraPlayer.sidePlayer.screenshot();
    final Uint8List? mainScreenshot =
        await cameraPlayer.mainPlayer.screenshot();

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
      await sl<ApiService>().addImageToVisitor(
          sl<AppService>().token, visitor.id, "card", cardImage);
      cardImage.delete();
    }
    if (await inSideImage.exists()) {
      await sl<ApiService>().addImageToVisitor(
          sl<AppService>().token, visitor.id, "in_side", inSideImage);
      inSideImage.delete();
    }
    if (await entranceImage.exists()) {
      await sl<ApiService>().addImageToVisitor(
          sl<AppService>().token, visitor.id, "entrance", entranceImage);
      entranceImage.delete();
    }
  }

  void printTicket(VisitorModel visitor) async {
    var printerManager = PrinterManager.instance;
    // print(printerManager.currentStatusUSB.toString());
    print(sl<AppService>().printer);
    printerManager.connect(
        type: PrinterType.usb,
        model: UsbPrinterInput(
            name: sl<AppService>().printer, productId: null, vendorId: null));
    await printerManager.send(
        type: PrinterType.usb, bytes: await _generateTicket(visitor));
    await printerManager.disconnect(type: PrinterType.usb);
  }

  // void printNetwork() async {
  //   const PaperSize paper = PaperSize.mm80;
  //   final profile = await CapabilityProfile.load();
  //   final printer = NetworkPrinter(paper, profile);

  //   final PosPrintResult res =
  //       await printer.connect('192.168.50.43', port: 9100);

  //   if (res == PosPrintResult.success) {
  //     await testReceipt(printer);
  //     printer.disconnect();
  //   }

  //   print('Print result: ${res.msg}');
  // }

  Widget _buildSearchMember() {
    final memberList = ref.watch(membersProvider);
    return Autocomplete<MemberModel>(
      initialValue:
          _selectedMember != null && _selectedMember!.status == "overdue"
              ? TextEditingValue(text: _selectedMember!.name!)
              : null,
      displayStringForOption: (MemberModel member) {
        return member.name!;
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable.empty();
        }
        return memberList.where((MemberModel member) =>
            member.name!.contains(textEditingValue.text));
      },
      onSelected: (MemberModel member) {
        _selectedMember = member;
        debugPrint(member.name!);
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Material(
          elevation: 4,
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final option = options.elementAt(index);
              // List<String> plates = [];
              // if (option.vehicles != null) {
              //   for (var vehicle in option.vehicles!) {
              //     plates.add(vehicle.plateNumber!);
              //   }
              // }
              return ListTile(
                title: SubstringHighlight(
                  text: option.name!,
                  term: _memberController.text,
                  textStyleHighlight:
                      const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(option.stringVehicles!),
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
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            hintText: "ค้นหา เลขที่บ้าน",
            prefixIcon: const Icon(Icons.search),
          ),
        );
      },
    );
  }

  void alertError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
