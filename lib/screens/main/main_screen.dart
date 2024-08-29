import 'dart:async';
import 'dart:io';

import 'package:carpark/screens/main/cubit/player_cubit.dart';
import 'package:carpark/screens/member_list/cubit/member_list_cubit.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:carpark/constants.dart';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/camera_model.dart';
import 'package:carpark/models/gate_log_model.dart';
import 'package:carpark/models/last_gate.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/providers/members_notifier.dart';
import 'package:carpark/screens/display_screen.dart';
import 'package:carpark/screens/entrance_screen.dart';
import 'package:carpark/screens/exit_screen.dart';
import 'package:carpark/screens/gate_log_screen.dart';
import 'package:carpark/screens/member_list/member_list_screen.dart';
import 'package:carpark/screens/member/member_screen.dart';
import 'package:carpark/screens/report_screen.dart';
import 'package:carpark/screens/setting_screen.dart';
import 'package:carpark/screens/sign_in/sign_in_screen.dart';
import 'package:carpark/screens/user_screen.dart';
import 'package:carpark/screens/visitor_screen.dart';
import 'package:carpark/services/api_service.dart';
import 'package:carpark/services/app_service.dart';

final lastGateProvider =
    StateNotifierProvider<LastGateNotifier, LastGate>((ref) {
  return LastGateNotifier(
      LastGate(gateIn: GateLogModel(0), gateOut: GateLogModel(0)));
});

// final membersProvider =
//     StateNotifierProvider<MembersNotifier, List<MemberModel>>((ref) {
//   return MembersNotifier();
// });

final cameraMapProvider =
    Provider<Map<String, CameraModel>>((ref) => <String, CameraModel>{});

class MainScreen extends StatefulHookConsumerWidget {
  static const String id = 'main_screen';

  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final wsUrl = '$kHostWS/ws';
  late WebSocket channel;
  bool loadingLastGate = false;

  var _currentScreen = "";
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  final MemberModel _memberModel = MemberModel(id: 0, vehicles: []);

  final _nameController = TextEditingController();
  final _telController = TextEditingController();

  initWebSocketChannelConnection() async {
    final lastGate = ref.read(lastGateProvider.notifier);
    var channel = WebSocketChannel.connect(Uri.parse(wsUrl));
    channel.stream.listen((streamData) {
      print(streamData);
      lastGate.setFromJson(streamData);
    });
  }

  initWebSocketConnection() async {
    print("conecting...");
    channel = await connectWs();
    print("socket connection initializied");
    channel.done.then((dynamic _) => _onDisconnected());
    broadcastNotifications();
  }

  broadcastNotifications() {
    final lastGate = ref.read(lastGateProvider.notifier);
    channel.listen((streamData) {
      print(streamData);
      lastGate.setFromJson(streamData);
    }, onDone: () {
      print("conecting aborted");
      initWebSocketConnection();
    }, onError: (e) {
      print('Server error: $e');
      initWebSocketConnection();
    });
  }

  connectWs() async {
    try {
      return await WebSocket.connect(wsUrl);
    } catch (e) {
      print("Error! can not connect WS connectWs $e");
      await Future.delayed(const Duration(milliseconds: 5000));
      return await connectWs();
    }
  }

  void _onDisconnected() {
    initWebSocketConnection();
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      initWebSocketChannelConnection();
    } else {
      initWebSocketConnection();
    }

    getLastGate();
    getMember();
    getCameraList().then((value) {
      if (!kIsWeb) {
        setPlayer(value);
      }
    });

    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _telController.dispose();
    super.dispose();
  }

  void alertError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<Map<String, CameraModel>> getCameraList() async {
    final camera = ref.read(cameraMapProvider);
    final data = await sl<ApiService>().getCameraList(sl<AppService>().token);
    for (CameraModel cam in data) {
      camera[cam.name] = cam;
    }
    return camera;
  }

  void getMember() {
    context.read<MemberListCubit>().listMembers();
  }

  Future<void> getLastGate() async {
    if (!loadingLastGate) {
      loadingLastGate = true;
      final lastGate = ref.read(lastGateProvider.notifier);
      sl<ApiService>().getLastGate(sl<AppService>().token).then((value) {
        lastGate.setGateIn(value.gateIn);
        lastGate.setGateOut(value.gateOut);
        loadingLastGate = false;
      }).onError((error, stackTrace) {
        alertError(error.toString());
        loadingLastGate = false;
      });
    }
  }

  Future<void> getLastGateIn() async {
    if (!loadingLastGate) {
      loadingLastGate = true;
      final lastGate = ref.read(lastGateProvider.notifier);
      sl<ApiService>().getGateIn(sl<AppService>().token).then((value) {
        lastGate.setGateIn(value.gateLog);
        loadingLastGate = false;
      }).onError((error, stackTrace) {
        alertError(error.toString());
        loadingLastGate = false;
      });
    }
  }

  Future<void> getLastGateOut() async {
    if (!loadingLastGate) {
      loadingLastGate = true;
      final lastGate = ref.read(lastGateProvider.notifier);
      sl<ApiService>().getGateOut(sl<AppService>().token).then((value) {
        lastGate.setGateOut(value.gateLog);
        loadingLastGate = false;
      }).onError((error, stackTrace) {
        alertError(error.toString());
        loadingLastGate = false;
      });
    }
  }

  void selectedPage(String page) {
    final camera = ref.watch(cameraMapProvider);
    switch (page) {
      case 'ENTRANCE':
        getLastGateIn();
        setPlayer(camera);
        break;
      case 'EXIT':
        getLastGateOut();
        setExitPlayer(camera);
        break;
      default:
        stopAll();
    }
    setState(() {
      _currentScreen = page;
    });
  }

  void setPlayer(Map<String, CameraModel> camera) {
    if (!kIsWeb) {
      var cam = camera['ENTRANCE'];
      if (cam != null) {
        context.read<PlayerCubit>().setMainPlayer(cam.toUrl());
        // player.setMainPlayer(cam.toUrl());
      }
      var cameraSide = camera['IN_SIDE'];
      if (cameraSide != null) {
        context.read<PlayerCubit>().setSidePlayer(cameraSide.toUrl());
        // player.setSidePlayer(cameraSide.toUrl());
      }
      var cameraCard = camera['CARD'];
      if (cameraCard != null) {
        context.read<PlayerCubit>().setCardPlayer(cameraCard.toUrl());
        // player.setCardPlayer(cameraCard.toUrl());
      }
    }
  }

  void setExitPlayer(Map<String, CameraModel> camera) {
    if (!kIsWeb) {
      var cam = camera['EXIT'];
      if (cam != null) {
        context.read<PlayerCubit>().setMainPlayer(cam.toUrl());
        // player.setMainPlayer(cam.toUrl());
      }
      var cameraSide = camera['OUT_SIDE'];
      if (cameraSide != null) {
        context.read<PlayerCubit>().setSidePlayer(cameraSide.toUrl());
        // player.setSidePlayer(cameraSide.toUrl());
      }
    }
  }

  void stopAll() {
    context.read<PlayerCubit>().stopAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorPrimary,
        title: const Text(
          'Car Park',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        actions: _buildActionBar(),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.compact,
              openSideMenuWidth: 200,
              compactSideMenuWidth: 60,
              hoverColor: Colors.blue[100],
              selectedColor: Colors.lightBlue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
            ),
            items: [
              SideMenuItem(
                title: 'ทางเข้า',
                onTap: (page, _) {
                  selectedPage('ENTRANCE');
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.door_front_door_outlined),
                tooltipContent: "ทางเข้า",
              ),
              SideMenuItem(
                title: 'ทางออก',
                onTap: (page, _) {
                  selectedPage('EXIT');
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.door_back_door_outlined),
                tooltipContent: "ทางออก",
              ),
              SideMenuItem(
                title: 'ผู้ติดต่อ',
                onTap: (page, _) {
                  selectedPage('VISITOR');
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.badge),
              ),
              SideMenuItem(
                title: 'บันทึกเข้า-ออก',
                onTap: (page, _) {
                  selectedPage('LOG');
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.commute),
              ),
              SideMenuItem(
                title: 'สมาชิก',
                onTap: (page, _) {
                  selectedPage('MEMBER');
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.person_search),
              ),
              SideMenuItem(
                title: 'รายงาน',
                onTap: (page, _) {
                  selectedPage('REPORT');
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.summarize),
              ),
              SideMenuItem(
                title: 'จอทางเข้า',
                onTap: (page, _) {
                  Navigator.of(context).pushNamed(DisplayScreen.id,
                      arguments: DisplayScreen.gateIn);
                },
                icon: const Icon(Icons.turn_right),
                tooltipContent: "จอทางเข้า",
              ),
              SideMenuItem(
                title: 'จอทางออก',
                onTap: (page, _) {
                  Navigator.of(context).pushNamed(DisplayScreen.id,
                      arguments: DisplayScreen.gateOut);
                },
                icon: const Icon(Icons.turn_left),
                tooltipContent: "จอทางออก",
              ),
              SideMenuItem(
                title: 'ตั้งค่า',
                onTap: (page, _) {
                  selectedPage('SETTING');
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.settings),
              ),
              SideMenuItem(
                title: 'ผู้ใช้งาน',
                onTap: (page, _) {
                  selectedPage('USER');
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.supervisor_account_rounded),
              ),
              SideMenuItem(
                title: 'ออกโปรแกรม',
                icon: const Icon(Icons.exit_to_app),
                onTap: (page, _) {
                  selectedPage('LOGOUT');
                  sl<AppService>().logout().then((value) {
                    Navigator.of(context).pushReplacement(_createRouteSignIn());
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                Container(
                  color: Colors.white,
                  child: const EntranceScreen(),
                ),
                Container(
                  color: Colors.white,
                  child: const ExitScreen(),
                ),
                Container(
                  color: Colors.white,
                  child: const VisitorScreen(),
                ),
                Container(
                  color: Colors.white,
                  child: const GateLogScreen(),
                ),
                Container(
                  color: Colors.white,
                  child: const MemberListScreen(),
                ),
                Container(
                  color: Colors.white,
                  child: const ReportScreen(),
                ),
                Container(
                  color: Colors.white,
                  child: Container(),
                ),
                Container(
                  color: Colors.white,
                  child: Container(),
                ),
                Container(
                  color: Colors.white,
                  child: const SettingScreen(),
                ),
                Container(
                  color: Colors.white,
                  child: const UserScreen(),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Exit',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Route _createRouteSignIn() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  List<Widget> _buildActionBar() {
    List<Widget> widget = [];
    switch (_currentScreen) {
      case "MEMBER":
        widget.add(
          IconButton(
            icon: const Icon(Icons.person_add),
            tooltip: 'สร้างสมาชิกใหม่',
            onPressed: () {
              onPressedAddMember(context);
            },
          ),
        );
        widget.add(
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Export Member',
            onPressed: () {
              onPressedExportMember(context);
            },
          ),
        );
        break;
      default:
    }

    return widget;
  }

  void onPressedAddMember(BuildContext context) {
    _memberModel.name = '';
    _memberModel.telephone = '';
    _memberModel.type = 'resident';
    _memberModel.status = 'active';

    _nameController.text = '';
    _telController.text = '';

    Alert(
        context: context,
        title: "สร้างสมาชิกใหม่",
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                onChanged: (value) {
                  _memberModel.name = value;
                },
                autofocus: false,
                autocorrect: false,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'ชื่อ',
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
                onChanged: (value) {
                  _memberModel.telephone = value;
                },
                autofocus: false,
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'โทรศัพท์.',
                  suffixIcon: const Icon(Icons.phone),
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
                initialValue: _memberModel.type,
                name: 'type',
                onChanged: (value) {
                  _memberModel.type = value;
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
                  labelText: 'สถานะ',
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                initialValue: _memberModel.status,
                name: 'status',
                onChanged: (value) {
                  _memberModel.status = value;
                },
                validator: FormBuilderValidators.required(),
                options: kStatusList
                    .map((lang) => FormBuilderFieldOption(value: lang))
                    .toList(growable: false),
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              createMember();
            },
            child: const Text(
              "สร้าง",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void createMember() {
    sl<ApiService>()
        .createMember(sl<AppService>().token, _memberModel)
        .then((value) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Create Member'),
          content: const Text('สร้างข้อมูลสมาชิกเรียบร้อย'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                Navigator.pop(context);
                Navigator.of(context)
                    .pushNamed(MemberScreen.id, arguments: value.id)
                    .then((value) => {getMember()});
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }).onError((error, stackTrace) {
      alertError(error.toString());
    });
  }

  void onPressedExportMember(BuildContext context) async {
    String dateTime = DateFormat("yyyy-MM-dd_HH-mm").format(DateTime.now());
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'member_list_$dateTime.xlsx',
    );

    if (outputFile != null) {
      final file = File(outputFile);

      sl<ApiService>().getExportMembers(sl<AppService>().token).then((value) {
        file.writeAsBytes(value);
      });
    }
  }
}
