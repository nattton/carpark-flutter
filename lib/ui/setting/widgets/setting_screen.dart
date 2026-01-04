import 'package:carpark/config/constants.dart';
import 'package:carpark/data/services/api/api_service.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/models/camera_model.dart';
import 'package:carpark/ui/live_player/view_models/live_player_viewmodel.dart';
import 'package:carpark/ui/setting/printer/view_models/printer_viewmodel.dart';
import 'package:carpark/ui/setting/widgets/camera_list_card.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SettingScreen extends WatchingStatefulWidget {
  const SettingScreen({required this.printerViewModel, super.key});
  final PrinterViewModel printerViewModel;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  PrinterViewModel get printerViewModel => widget.printerViewModel;
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
      printerViewModel.getPrinterListCommand.run();
      printerViewModel.getPrinterCommand.run();
    }
    getIt<LivePlayerViewmodel>().getCameraCommand.run();
  }

  @override
  Widget build(BuildContext context) {
    final cameraList = watchValue(
      (LivePlayerViewmodel viewModel) => viewModel.cameraList,
    );
    return ListView.builder(
      itemCount: cameraList.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Card(
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Printer : ',
                    style: TextStyle(
                      fontFamily: kDefaultFont,
                      fontSize: 16,
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
                          hint: const Text('Select Printer ...'),
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

  void onPressedRow(BuildContext context, CameraModel camera) {
    _ipAddressController.text = camera.ipAddress;
    _portController.text = camera.port;
    _usernameController.text = camera.username;
    _passwordController.text = camera.password;
    _pathController.text = camera.path;

    Alert(
      context: context,
      title: 'Camera : ${camera.name}',
      content: Column(
        children: [
          const SizedBox(height: 8),
          TextField(
            controller: _ipAddressController,
            autocorrect: false,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              labelText: 'IP Address',
              suffixIcon: const Icon(Icons.account_circle),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _portController,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Port',
              suffixIcon: const Icon(Icons.account_circle),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _usernameController,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Username',
              suffixIcon: const Icon(Icons.account_circle),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: const Icon(Icons.lock),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _pathController,
            autocorrect: false,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              labelText: 'Path',
              suffixIcon: const Icon(Icons.account_circle),
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
            saveCamera(camera);
          },
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  void saveCamera(CameraModel camera) {
    final cameraUpdate = camera.copyWith(
      ipAddress: _ipAddressController.text,
      port: _portController.text,
      username: _usernameController.text,
      password: _passwordController.text,
      path: _pathController.text,
    );
    getIt<ApiService>()
        .updateCamera(cameraUpdate.id, cameraUpdate)
        .then((value) {
          GoRouter.of(context).pop();
          getIt<LivePlayerViewmodel>().getCameraCommand.run();
        })
        .onError((error, stackTrace) {
          alertError(error.toString());
        });
  }
}
