import 'dart:async';
import 'package:carpark/injection_container.dart';
import 'package:carpark/models/camera_model.dart';
import 'package:carpark/models/gate_log_model.dart';
import 'package:carpark/models/last_gate_model.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/providers/camera_player.dart';
import 'package:carpark/screens/camera_screen.dart';
import 'package:carpark/screens/entrance_screen.dart';
import 'package:carpark/screens/exit_screen.dart';
import 'package:carpark/screens/gate_log_screen.dart';
import 'package:carpark/screens/member_list_screen.dart';
import 'package:carpark/screens/user_screen.dart';
import 'package:carpark/screens/visitor_screen.dart';
import 'package:carpark/services/api_service.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:carpark/services/app_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_screen.g.dart';

final lastGateProvider =
    StateNotifierProvider<LastGateNotifier, LastGateModel>((ref) {
  return LastGateNotifier(
      LastGateModel(gateIn: GateLogModel(0), gateOut: GateLogModel(0)));
});

final memberListProvider = Provider<List<MemberModel>>((ref) {
  return [];
});
final cameraMapProvider =
    Provider<Map<String, CameraModel>>((ref) => <String, CameraModel>{});

@riverpod
CameraPlayer cameraPlayer(CameraPlayerRef ref) {
  return CameraPlayer(
    mainPlayer: Player(
      id: 0,
      videoDimensions: const VideoDimensions(640, 360),
    ),
    sidePlayer: Player(
      id: 1,
      videoDimensions: const VideoDimensions(640, 360),
    ),
    cardPlayer: Player(
      id: 2,
      videoDimensions: const VideoDimensions(640, 360),
    ),
  );
}

class MainScreen extends StatefulHookConsumerWidget {
  static const String id = 'main_screen';

  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  var loadLast = false;
  var _currentScreen = "";
  late StreamSubscription periodicSub;
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    getMember();
    getCameraList().then((value) {
      var camera = value['ENTRANCE'];
      final player = ref.watch(cameraPlayerProvider);
      player.setMainPlayer(camera!.toUrl());
      var cameraSide = value['IN_SIDE'];
      player.setSidePlayer(cameraSide!.toUrl());
      var cameraCard = value['CARD'];
      player.setCardPlayer(cameraCard!.toUrl());
    });
    getLastGateIn();
    periodicSub = Stream.periodic(const Duration(milliseconds: 1000))
        .listen((_) => getLastGateIn());

    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
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

  Future<Map<String, CameraModel>> getCameraList() async {
    final camera = ref.read(cameraMapProvider);
    final data = await sl<ApiService>().getCameraList(sl<AppService>().token);
    for (CameraModel cam in data) {
      camera[cam.name] = cam;
    }
    return camera;
  }

  Future<void> getMember() async {
    final memberList = ref.read(memberListProvider);
    sl<ApiService>().getMemberList(sl<AppService>().token).then((value) {
      memberList.clear();
      memberList.addAll(value);
    }).onError((error, stackTrace) {
      alertError(error.toString());
    });
  }

  Future<void> getLastGateIn() async {
    final lastGate = ref.read(lastGateProvider.notifier);
    sl<ApiService>().getGateIn(sl<AppService>().token).then((value) {
      lastGate.setGateIn(value.gateLog);
    }).onError((error, stackTrace) {
      alertError(error.toString());
    });
  }

  Future<void> getLastGateOut() async {
    final lastGate = ref.read(lastGateProvider.notifier);
    sl<ApiService>().getGateOut(sl<AppService>().token).then((value) {
      lastGate.setGateOut(value.gateLog);
    }).onError((error, stackTrace) {
      alertError(error.toString());
    });
  }

  @override
  void dispose() {
    periodicSub.cancel();
    super.dispose();
  }

  void selectedPage(String page) {
    final player = ref.watch(cameraPlayerProvider);
    final camera = ref.watch(cameraMapProvider);
    switch (page) {
      case 'ENTRANCE':
        periodicSub.cancel();
        periodicSub = Stream.periodic(const Duration(milliseconds: 1000))
            .listen((_) => getLastGateIn());
        var cam = camera['ENTRANCE'];
        if (cam != null) {
          player.setMainPlayer(cam.toUrl());
        }
        var cameraSide = camera['IN_SIDE'];
        if (cameraSide != null) {
          player.setSidePlayer(cameraSide.toUrl());
        }
        var cameraCard = camera['CARD'];
        if (cameraCard != null) {
          player.setCardPlayer(cameraCard.toUrl());
        }
        break;
      case 'EXIT':
        periodicSub.cancel();
        periodicSub = Stream.periodic(const Duration(milliseconds: 1000))
            .listen((_) => getLastGateOut());
        var cam = camera['EXIT'];
        if (cam != null) {
          player.setMainPlayer(cam.toUrl());
        }
        var cameraSide = camera['OUT_SIDE'];
        if (cameraSide != null) {
          player.setSidePlayer(cameraSide.toUrl());
        }
        break;
      default:
        periodicSub.cancel();
        player.stopAll();
    }
    setState(() {
      _currentScreen = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Car Park',
        ),
        automaticallyImplyLeading: false,
        actions: _buildAppBar(),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.compact,
              openSideMenuWidth: 200,
              compactSideMenuWidth: 50,
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
                title: 'ตั้งค่ากล้อง',
                onTap: (page, _) {
                  selectedPage('CAMERA');
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.video_library),
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
                    Navigator.pop(context);
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
                  child: const CameraScreen(),
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

  List<Widget> _buildAppBar() {
    List<Widget> widget = [];
    if (_currentScreen == "MEMBER") {
      widget.add(
        IconButton(
          icon: const Icon(Icons.person_add),
          tooltip: 'สร้างสมาชิกใหม่',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')));
          },
        ),
      );
    }

    return widget;
  }
}
