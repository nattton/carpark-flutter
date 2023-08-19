import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:carpark/constants.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/gate_log_model.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/models/smard_card_model.dart';
import 'package:carpark/models/visitor_model.dart';
import 'package:carpark/screens/main_screen.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:charset_converter/charset_converter.dart';
import 'package:csv/csv.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:substring_highlight/substring_highlight.dart';

class EntranceScreen extends StatefulHookConsumerWidget {
  const EntranceScreen({super.key});

  @override
  ConsumerState<EntranceScreen> createState() => _EntranceScreenState();
}

class _EntranceScreenState extends ConsumerState<EntranceScreen> {
  List<MemberModel> memberList = [];
  final focus = FocusNode();

  bool _isShowVisitor = false;
  bool _isReadCard = false;
  String _vehicleType = 'car';

  SmartCardModel _smartCard = SmartCardModel.empty();

  TextEditingController controller = TextEditingController();
  TextEditingController metasController = TextEditingController();

  int _selectedGateLogId = 0;

  MemberModel? _selectedMember;

  final _plateNumberController = TextEditingController();
  final _idCardController = TextEditingController();
  final _thaiNameController = TextEditingController();
  final _engNameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _genderController = TextEditingController();
  final _addressNameController = TextEditingController();
  final _ageNameController = TextEditingController();
  final _readDateTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getMember();
    }
  }

  @override
  Widget build(BuildContext context) {
    final gateLog = ref.watch(lastGateProvider).gateIn;
    final player = ref.watch(cameraPlayerProvider);
    return gateLog.id != 0
        ? Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () => openDoor("in"),
                          child: const Text("เปิดประตู ขาเข้า"),
                        ),
                        _isShowVisitor
                            ? ElevatedButton(
                                onPressed: () => openVisitior(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.red, // Background color
                                ),
                                child: const Text("ยกเลิก"),
                              )
                            : ElevatedButton(
                                onPressed: () => showVisitorFromEmpty(),
                                child: const Text("สร้างผู้ติดต่อ"),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _isShowVisitor ? _buildVisitorForm() : _buildViewer(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 2 - 60,
                        maxHeight:
                            (MediaQuery.of(context).size.width / 2 - 60) /
                                16 *
                                9,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Video(
                        player: player.mainPlayer,
                        scale: 1.0, // default
                        showControls: false, // default
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 2 - 60,
                        maxHeight:
                            (MediaQuery.of(context).size.width / 2 - 60) /
                                16 *
                                9,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Video(
                        player: player.sidePlayer,
                        scale: 1.0, // default
                        showControls: false, // default
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Container();
  }

  Widget _buildViewer() {
    final gateLog = ref.watch(lastGateProvider).gateIn;
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: gateLog.color(),
          width: 4.0,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const SizedBox(
            height: 10.0,
          ),
          Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  Container(
                    height: 40,
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        "วันที่: ${gateLog.dateFormat()}",
                        style: kGateStyle,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        "เวลา: ${gateLog.timeFormat()}",
                        style: kGateStyle,
                      ),
                    ),
                  ),
                ],
              ),
              gateLog.memberId! == 0
                  ? TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: Colors.red,
                          child: const Center(
                            child: Text(
                              "ผู้ติดต่อ",
                              style: kGateStyle,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          color: Colors.red,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () => showVisitorFromSelect(gateLog),
                              child: const Text("สร้างผู้ติดต่อจากรถคันนี้"),
                            ),
                          ),
                        ),
                      ],
                    )
                  : TableRow(
                      children: <Widget>[
                        Container(
                          height: 40,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              "ชื่อ : ${gateLog.member!.name}",
                              style: kGateStyle,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              gateLog.plateNumber!,
                              style: kGateStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
              gateLog.member?.status == 'overdue'
                  ? TableRow(
                      children: <Widget>[
                        Container(
                          height: 40,
                          color: gateLog.color(),
                          child: const Center(
                            child: Text(
                              kOverdueText,
                              style: kGateStyle,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          color: gateLog.color(),
                          child: const Center(
                              child: Text(
                            kOverdue2Text,
                            style: kGateStyle,
                          )),
                        ),
                      ],
                    )
                  : TableRow(
                      children: <Widget>[
                        Container(),
                        Container(),
                      ],
                    ),
              TableRow(
                children: <Widget>[
                  Container(
                    height: 60,
                    color: Colors.amberAccent,
                    child: Image.network(
                        "$kHostUrl/anpr_store/${gateLog.licensePlateImage!}"),
                  ),
                  Container(
                    height: 60,
                    color: Colors.amberAccent,
                    child: Center(
                      child: Text(
                        gateLog.anpr!,
                        style: kGateStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Image.network("$kHostUrl/anpr_store/${gateLog.captureImage!}"),
        ]),
      ),
    );
  }

  Widget _buildVisitorForm() {
    final player = ref.watch(cameraPlayerProvider);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const SizedBox(
            height: 10.0,
          ),
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
                      options: vehicleTypeMap.entries
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
                  onPressed: () => readSmartCard(),
                  child: const Text("อ่านข้อมูลจากบัตร"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => clearForm(),
                  child: const Text("ล้างข้อมูล"),
                ),
                ElevatedButton(
                  onPressed: () => saveAndPrint(),
                  child: const Text("บันทึกและพิมพ์"),
                ),
              ],
            ),
          ),
          _isReadCard
              ? Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: <Widget>[
                        TextField(
                          controller: _idCardController,
                          autofocus: true,
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'เลขประจำตัวประชาชน',
                            suffixIcon: Icon(Icons.numbers),
                            contentPadding:
                                EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
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
                            contentPadding:
                                EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
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
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
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
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        TextField(
                          controller: _ageNameController,
                          autofocus: false,
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'อายุ',
                            suffixIcon: Icon(Icons.calendar_month),
                            contentPadding:
                                EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                          ),
                        ),
                        TextField(
                          controller: _readDateTimeController,
                          autofocus: false,
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'วันที่อ่าน',
                            suffixIcon: Icon(Icons.calendar_today),
                            contentPadding:
                                EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 2 - 60,
                    maxHeight:
                        (MediaQuery.of(context).size.width / 2 - 60) / 16 * 9,
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                  child: Video(
                    player: player.cardPlayer,
                    scale: 1.0, // default
                    showControls: false, // default
                  ),
                ),
        ]),
      ),
    );
  }

  void showVisitorFromSelect(GateLogModel gateLog) {
    _plateNumberController.text = gateLog.plateNumber!;
    _selectedGateLogId = gateLog.id;
    openVisitior();
  }

  void showVisitorFromEmpty() {
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

  Future<void> getMember() async {
    sl<ApiService>().getMemberList(sl<AppService>().token).then((value) {
      setState(() {
        memberList = value;
      });
    }).onError((error, stackTrace) {
      alertError(error.toString());
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/SIAM-ID/Data.txt');
  }

  Future<dynamic> readData() async {
    try {
      final file = await _localFile;

      // Read the file
      final input = File(file.path).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();
      return fields;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  void clearForm() {
    _smartCard = SmartCardModel.empty();
    _idCardController.clear();
    _thaiNameController.clear();
    _engNameController.clear();
    _birthdateController.clear();
    _genderController.clear();
    _addressNameController.clear();
    _ageNameController.clear();
    _readDateTimeController.clear();
  }

  void readSmartCard() async {
    _isReadCard = true;
    try {
      final listCSV = await readData() as List;
      final cardData = listCSV.last;
      _smartCard = SmartCardModel.fromArray(cardData);
      _idCardController.text = _smartCard.idCard;
      _thaiNameController.text = _smartCard.thaiName;
      _engNameController.text = _smartCard.engName;
      _birthdateController.text = _smartCard.birthdate;
      _genderController.text = _smartCard.gender;
      _addressNameController.text = _smartCard.address;
      _ageNameController.text = _smartCard.age;
      _readDateTimeController.text = _smartCard.readDateTime;
      setState(() {});
    } catch (error) {
      Logger().e(error);
    }
  }

  Future<List<int>> testPrint() async {
    List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();

    final generator = Generator(PaperSize.mm80, profile, spaceBetweenRows: 8);
    bytes += generator.setGlobalCodeTable('Thai');

    for (var charset in await CharsetConverter.availableCharsets()) {
      print(charset);
    }

    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
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
    bytes += generator.textEncoded(
        await charsetConvert('บัตรจอดรถ\nParking Ticket'),
        styles: const PosStyles(
            align: PosAlign.center,
            height: PosTextSize.size1,
            width: PosTextSize.size1,
            fontType: PosFontType.fontA));

    // Print image:
    final ByteData data = await rootBundle.load('images/logo.png');
    final Uint8List imgBytes = data.buffer.asUint8List();
    final image = img.decodeImage(imgBytes)!;
    bytes += generator.image(image);

    bytes += generator.qrcode(visitor.dateTimeNanoShortFormat());

    if (vehicleTypeMap.containsKey(visitor.type)) {
      var vehicleType = vehicleTypeMap[visitor.type];
      bytes +=
          generator.textEncoded(await charsetConvert("ประเภท : $vehicleType"),
              styles: const PosStyles(
                align: PosAlign.left,
                height: PosTextSize.size1,
                width: PosTextSize.size1,
              ));
    }
    bytes += generator.textEncoded(
        await charsetConvert("ทะเบียน : ${visitor.plateNumber!}"),
        styles: const PosStyles(
          align: PosAlign.left,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ));

    bytes += generator.row([
      PosColumn(
        width: 6,
        styles: const PosStyles(underline: true),
        textEncoded: await charsetConvert('วันที่'),
      ),
      PosColumn(
        width: 6,
        styles: const PosStyles(underline: true),
        textEncoded: await charsetConvert('เวลา'),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: gateLog.dateFormat(),
        width: 6,
        styles: const PosStyles(
          align: PosAlign.left,
          bold: true,
        ),
      ),
      PosColumn(
        text: gateLog.timeFormat(),
        width: 6,
        styles: const PosStyles(
          align: PosAlign.left,
          bold: true,
        ),
      ),
    ]);
    bytes += generator.feed(2);
    bytes += generator.textEncoded(
      await charsetConvert('เวลาออก _______________'),
      styles: const PosStyles(
        align: PosAlign.left,
        height: PosTextSize.size1,
      ),
      linesAfter: 2,
    );

    if (_selectedMember != null) {
      bytes += generator.textEncoded(
        await charsetConvert("ติดต่อ : ${_selectedMember?.name}"),
        styles: const PosStyles(
          align: PosAlign.left,
          height: PosTextSize.size1,
        ),
        linesAfter: 1,
      );
    } else {
      bytes += generator.textEncoded(
        await charsetConvert('ติดต่อ _______________'),
        styles: const PosStyles(
          align: PosAlign.left,
          height: PosTextSize.size1,
        ),
        linesAfter: 1,
      );
    }

    bytes += generator.textEncoded(
      await charsetConvert('ตราประทับ'),
      styles: const PosStyles(
        bold: true,
        align: PosAlign.center,
        height: PosTextSize.size1,
      ),
      linesAfter: 1,
    );

    final ByteData dataFrame = await rootBundle.load('images/frame_stamp.png');
    final Uint8List imgFrameBytes = dataFrame.buffer.asUint8List();
    final imageFrame = img.decodeImage(imgFrameBytes)!;
    bytes += generator.image(imageFrame);

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
        idCard: _idCardController.text,
        thaiName: _thaiNameController.text,
        engName: _engNameController.text,
        birthdate: _birthdateController.text,
        gender: _genderController.text,
        address: _addressNameController.text,
        age: _ageNameController.text,
        visitorImages: []);
    sl<ApiService>()
        .createVisitor(sl<AppService>().token, visitor)
        .then((value) async {
      printReceipt(value);
      addImageToVisitor(value);
      setState(() {
        _isShowVisitor = false;
        _isReadCard = false;
      });
    }).onError((error, stackTrace) {
      alertError(error.toString());
    });
  }

  void addImageToVisitor(VisitorModel visitor) async {
    final cameraPlayer = ref.watch(cameraPlayerProvider);
    File cardImage = await _tempImage("card");
    File inSideImage = await _tempImage("in_side");
    File entranceImage = await _tempImage("entrance");
    cameraPlayer.cardPlayer.takeSnapshot(cardImage, 640, 360);
    cameraPlayer.sidePlayer.takeSnapshot(inSideImage, 640, 360);
    cameraPlayer.mainPlayer.takeSnapshot(entranceImage, 640, 360);
    await sl<ApiService>().addImageToVisitor(
        sl<AppService>().token, visitor.id, "card", cardImage);
    await sl<ApiService>().addImageToVisitor(
        sl<AppService>().token, visitor.id, "in_side", inSideImage);
    await sl<ApiService>().addImageToVisitor(
        sl<AppService>().token, visitor.id, "entrance", entranceImage);
  }

  void printReceipt(VisitorModel visitor) async {
    var printerManager = PrinterManager.instance;
    // print(printerManager.currentStatusUSB.toString());

    // var devices = [];
    // _scan(PrinterType type, {bool isBle = false}) {
    //   // Find printers
    //   printerManager.discovery(type: type, isBle: isBle).listen((device) {
    //     devices.add(device);
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content:
    //           Text('${device.name} | ${device.productId} | ${device.vendorId}'),
    //     ));
    //   });
    // }

    // _scan(PrinterType.usb);

    printerManager.connect(
        type: PrinterType.usb,
        model: UsbPrinterInput(
            name: kPrinterName, productId: null, vendorId: null));
    await printerManager.send(
        type: PrinterType.usb, bytes: await _generateTicket(visitor));
    await printerManager.disconnect(type: PrinterType.usb);
  }

  void printNetwork() async {
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);

    final PosPrintResult res =
        await printer.connect('192.168.50.43', port: 9100);

    if (res == PosPrintResult.success) {
      await testReceipt(printer);
      printer.disconnect();
    }

    print('Print result: ${res.msg}');
  }

  Future testReceipt(NetworkPrinter printer) async {
    printer.setGlobalCodeTable('CP874');
    // printer.printCodeTable();
    Uint8List encoded = await CharsetConverter.encode("windows-874", "ทดสอบ");
    printer.textEncoded(encoded);
    printer.feed(2);
    printer.cut();
  }

  Widget _buildSearchMember() {
    return Autocomplete<MemberModel>(
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
              List<String> plates = [];
              if (option.vehicles != null) {
                for (var vehicle in option.vehicles!) {
                  plates.add(vehicle.plateNumber!);
                }
              }
              return ListTile(
                // title: Text(option.toString()),
                title: SubstringHighlight(
                  text: option.name!,
                  term: controller.text,
                  textStyleHighlight:
                      const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(plates.join(" | ")),
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
        this.controller = controller;

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
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text('Alert Message'),
    //         content: Text(msg),
    //         actions: [
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: const Text('Close'))
    //         ],
    //       );
    //     });
  }
}
