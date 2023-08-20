import 'package:carpark/components/camera_list_card.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/camera_model.dart';
import 'package:carpark/screens/main_screen.dart';
import 'package:carpark/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:carpark/services/app_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  List<CameraModel> cameraList = [];
  final _ipAddressController = TextEditingController();
  final _portController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pathController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCamera();
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cameraList.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return CameraListCard(
            camera: CameraModel(
                id: 0,
                name: '',
                ipAddress: '',
                port: '',
                username: '',
                password: '',
                path: ''),
            onTap: () {},
          );
        }
        return CameraListCard(
            camera: cameraList[index - 1],
            onTap: () => onPressedRow(context, cameraList[index - 1]));
      },
    );
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
    camera.ipAddress = _ipAddressController.text;
    camera.port = _portController.text;
    camera.username = _usernameController.text;
    camera.password = _passwordController.text;
    camera.path = _pathController.text;
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
