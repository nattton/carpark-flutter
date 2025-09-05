import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../config/constants.dart';
import '../../../data/services/api/api_service.dart';
import '../../../injector/injector.dart';
import '../../../models/camera_model.dart';
import '../../home/widgets/home_screen.dart';
import '../printer/view_models/printer_viewmodel.dart';
import 'camera_list_card.dart';

class SettingScreen extends ConsumerStatefulWidget {
  final PrinterViewModel printerViewModel;

  const SettingScreen({super.key, required this.printerViewModel});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  final _log = Logger('SettingScreen');
  PrinterViewModel get printerViewModel => widget.printerViewModel;
  List<CameraModel> cameraList = [];
  final _ipAddressController = TextEditingController();
  final _portController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pathController = TextEditingController();

  void alertError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      printerViewModel.getPrinterListCommand.execute();
      printerViewModel.getPrinterCommand.execute();
    }
    getCamera();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cameraList.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Card(
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Printer : ',
                    style: TextStyle(
                      fontFamily: kDefaultFont,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: printerViewModel.getPrinterListCommand,
                  builder: (context, printerList, _) {
                    return ValueListenableBuilder(
                      valueListenable: printerViewModel.getPrinterCommand,
                      builder: (context, printerName, _) {
                        return DropdownButton<String>(
                          hint: Text('Select Printer ...'),
                          value: printerName,
                          icon: const Icon(Icons.print),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            printerViewModel.updatePrinterCommand(value);
                          },
                          items: printerList.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        }
        if (index == 1) {
          return CameraListCard(
            camera: CameraModel(
              id: 0,
              name: '',
              ipAddress: '',
              port: '',
              username: '',
              password: '',
              path: '',
            ),
            onTap: () {},
          );
        }
        return CameraListCard(
          camera: cameraList[index - 2],
          onTap: () => onPressedRow(context, cameraList[index - 2]),
        );
      },
    );
  }

  @override
  void dispose() {
    _ipAddressController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _pathController.dispose();
    super.dispose();
  }

  Future<void> getCamera() async {
    getIt<ApiService>()
        .getCameraList()
        .then((value) {
          setState(() {
            cameraList = value;
          });
          final camera = ref.read(cameraMapProvider);
          for (final cam in cameraList) {
            camera[cam.name] = cam;
          }
        })
        .onError((error, stackTrace) {
          alertError(error.toString());
        });
  }

  void onPressedRow(BuildContext context, CameraModel camera) {
    _ipAddressController.text = camera.ipAddress;
    _portController.text = camera.port;
    _usernameController.text = camera.username;
    _passwordController.text = camera.password;
    _pathController.text = camera.path;

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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
            saveCamera(camera);
          },
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  void saveCamera(CameraModel camera) {
    camera = camera.copyWith(
      ipAddress: _ipAddressController.text,
      port: _portController.text,
      username: _usernameController.text,
      password: _passwordController.text,
      path: _pathController.text,
    );
    getIt<ApiService>()
        .updateCamera(camera.id, camera)
        .then((value) {
          GoRouter.of(context).pop();
          getCamera();
        })
        .onError((error, stackTrace) {
          alertError(error.toString());
        });
  }
}
