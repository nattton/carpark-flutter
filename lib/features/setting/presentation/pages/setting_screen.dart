import 'package:carpark/constants.dart';
import 'package:carpark/features/main/presentation/pages/main_screen.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/camera_model.dart';
import 'package:carpark/features/setting/presentation/widget/camera_header_card.dart';
import 'package:carpark/features/setting/presentation/widget/camera_list_card.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:thermal_printer/thermal_printer.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  List<String> devices = ["Select Printer..."];
  List<CameraModel> cameraList = [];
  final _ipAddressController = TextEditingController();
  final _portController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pathController = TextEditingController();
  final _controlPortController = TextEditingController();
  final _controlGateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _scan(PrinterType.usb);
    }
    getCamera();
  }

  @override
  void dispose() {
    _ipAddressController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _pathController.dispose();
    _controlPortController.dispose();
    _controlGateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cameraList.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Card(
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Printer : ',
                  style: TextStyle(
                      fontFamily: kDefaultFont,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              DropdownButton<String>(
                value: sl<AppService>().printer.isEmpty ||
                        !devices.contains(sl<AppService>().printer)
                    ? devices.first
                    : sl<AppService>().printer,
                icon: const Icon(Icons.print),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    sl<AppService>().savePrinter(value!);
                  });
                },
                items: devices.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ]),
          );
        }
        if (index == 1) {
          return const CameraHeaderCard();
        }
        return CameraListCard(
            camera: cameraList[index - 2],
            onTap: () => onPressedRow(context, cameraList[index - 2]));
      },
    );
  }

  void _scan(PrinterType type, {bool isBle = false}) {
    // Find printers
    var printerManager = PrinterManager.instance;
    printerManager.discovery(type: type, isBle: isBle).listen((device) {
      if (!devices.contains(device.name)) {
        devices.add(device.name);
        // print(
        //     'Printer Device ${device.name} | ${device.productId} | ${device.vendorId}');
        setState(() {});
      }
    });
  }

  Future<void> getCamera() async {
    sl<ApiService>().getCameraList(sl<AppService>().token).then((value) {
      setState(() {
        cameraList = value;
      });
      final camera = ref.read(cameraMapProvider);
      for (CameraModel cam in cameraList) {
        camera[cam.name] = cam;
      }
    }).onError((error, stackTrace) {
      alertError(error.toString());
    });
  }

  void saveCamera(CameraModel camera) {
    camera = camera.copyWith(
      ipAddress: _ipAddressController.text,
      port: _portController.text,
      username: _usernameController.text,
      password: _passwordController.text,
      path: _pathController.text,
      controlPort: _controlPortController.text,
      controlGate: _controlGateController.text,
    );

    sl<ApiService>()
        .updateCamera(sl<AppService>().token, camera.id, camera)
        .then((value) {
      Navigator.pop(context);
      getCamera();
    }).onError((error, stackTrace) {
      alertError(error.toString());
    });
  }

  void onPressedRow(BuildContext context, CameraModel camera) {
    _ipAddressController.text = camera.ipAddress;
    _portController.text = camera.port;
    _usernameController.text = camera.username;
    _passwordController.text = camera.password;
    _pathController.text = camera.path;
    _controlPortController.text = camera.controlPort;
    _controlGateController.text = camera.controlGate;

    Alert(
        context: context,
        title: "Camera : ${camera.name}",
        content: Column(
          children: [
            const SizedBox(height: 8.0),
            TextField(
              controller: _ipAddressController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: 'IP Address',
                suffixIcon: const Icon(Icons.account_circle),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _portController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Port',
                suffixIcon: const Icon(Icons.account_circle),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _usernameController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Username',
                suffixIcon: const Icon(Icons.account_circle),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              autofocus: false,
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: const Icon(Icons.lock),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _pathController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: 'Path',
                suffixIcon: const Icon(Icons.account_circle),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _controlPortController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Control Port',
                suffixIcon: const Icon(Icons.numbers),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _controlGateController,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Control Gate',
                suffixIcon: const Icon(Icons.door_front_door),
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
              saveCamera(camera);
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void alertError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
