import 'dart:async';
import 'dart:io';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../config/constants.dart';
import '../../../data/services/api/api_service.dart';
import '../../../features/gateway/presentation/page/entrance_screen.dart';
import '../../../features/gateway/presentation/page/exit_screen.dart';
import '../../../injector/injector.dart';
import '../../../models/models.dart';
import '../../../providers/camera_player.dart';
import '../../auth/logout/view_models/logout_viewmodel.dart';
import '../../gate_log/widgets/gate_log_screen.dart';
import '../../member/widgets/member_list_screen.dart';
import '../../registered_user/widgets/page/registered_user_list_screen.dart';
import '../../registered_user/widgets/page/registered_user_not_check_out_screen.dart';
import '../../report/widgets/report_screen.dart';
import '../../setting/printer/view_models/printer_viewmodel.dart';
import '../../setting/widgets/setting_screen.dart';
import '../../user/widgets/user_screen.dart';
import '../../visitor/widgets/visitor_screen.dart';
import '../view_models/home_viewmodel.dart';

final lastGateProvider = StateNotifierProvider<LastGateNotifier, LastGate>(
  (ref) => LastGateNotifier(
    LastGate(gateIn: GateLogModel(0), gateOut: GateLogModel(0)),
  ),
);

final cameraMapProvider = Provider<Map<String, CameraModel>>(
  (ref) => <String, CameraModel>{},
);

final cameraPlayerProvider = Provider<CameraPlayer>(
  (ref) => CameraPlayer.initialize(),
);

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({
    super.key,
    required this.homeViewModel,
    required this.logoutViewModel,
  });

  final HomeViewModel homeViewModel;
  final LogoutViewModel logoutViewModel;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _log = Logger('HomeScreen');
  HomeViewModel get homeViewModel => widget.homeViewModel;
  LogoutViewModel get logoutViewModel => widget.logoutViewModel;

  final wsUrl = '$kCurrentHost/ws'.replaceAll('http', 'ws');
  late WebSocket channel;

  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  Future<void> initWebSocketChannelConnection() async {
    final lastGate = ref.read(lastGateProvider.notifier);
    final channel = WebSocketChannel.connect(Uri.parse(wsUrl));
    channel.stream.listen((streamData) {
      _log.info(streamData);
      lastGate.setFromJson(streamData);
    });
  }

  Future<void> initWebSocketConnection() async {
    _log.info("conecting...");
    channel = await connectWs();
    _log.info("socket connection initializied");
    channel.done.then((dynamic _) => _onDisconnected());
    broadcastNotifications();
  }

  void broadcastNotifications() {
    final lastGate = ref.read(lastGateProvider.notifier);
    channel.listen(
      (streamData) {
        _log.info(streamData);
        lastGate.setFromJson(streamData);
      },
      onDone: () {
        _log.info("conecting aborted");
        initWebSocketConnection();
      },
      onError: (e) {
        _log.info('Server error: $e');
        initWebSocketConnection();
      },
    );
  }

  Future connectWs() async {
    try {
      return await WebSocket.connect(wsUrl);
    } catch (e) {
      _log.warning('Error! can not connect WS connectWs $e');
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
    getCameraList().then((value) {
      if (!kIsWeb) {
        final camera = value['ENTRANCE'];
        final cameraSide = value['IN_SIDE'];
        final cameraCard = value['CARD'];
        final player = ref.watch(cameraPlayerProvider);
        player.setMainPlayer(camera!.toUrl());
        player.setSidePlayer(cameraSide!.toUrl());
        player.setCardPlayer(cameraCard!.toUrl());
      }
    });

    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
  }

  void alertError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<Map<String, CameraModel>> getCameraList() async {
    final camera = ref.read(cameraMapProvider);
    final data = await getIt<ApiService>().getCameraList();
    for (final cam in data) {
      camera[cam.name] = cam;
    }
    return camera;
  }

  Future<void> getLastGate() async {
    final lastGate = ref.read(lastGateProvider.notifier);
    try {
      final result = await getIt<ApiService>().getLastGate();
      lastGate.setGateIn(result.gateIn);
      lastGate.setGateOut(result.gateOut);
    } catch (e) {
      alertError(e.toString());
    }
  }

  Future<void> getLastGateIn() async {
    final lastGate = ref.read(lastGateProvider.notifier);
    try {
      final result = await getIt<ApiService>().getGateIn();
      lastGate.setGateIn(result.gateLog);
    } catch (e) {
      alertError(e.toString());
    }
  }

  Future<void> getLastGateOut() async {
    final lastGate = ref.read(lastGateProvider.notifier);
    try {
      final result = await getIt<ApiService>().getGateOut();
      lastGate.setGateOut(result.gateLog);
    } catch (e) {
      alertError(e.toString());
    }
  }

  void selectedPage(String page) {
    final player = ref.read(cameraPlayerProvider);
    final camera = ref.read(cameraMapProvider);
    switch (page) {
      case 'ENTRANCE':
        getLastGateIn();
        if (!kIsWeb) {
          final cam = camera['ENTRANCE'];
          if (cam != null) {
            player.setMainPlayer(cam.toUrl());
          }
          final cameraSide = camera['IN_SIDE'];
          if (cameraSide != null) {
            player.setSidePlayer(cameraSide.toUrl());
          }
          final cameraCard = camera['CARD'];
          if (cameraCard != null) {
            player.setCardPlayer(cameraCard.toUrl());
          }
        }
        break;
      case 'EXIT':
        getLastGateOut();
        if (!kIsWeb) {
          final cam = camera['EXIT'];
          if (cam != null) {
            player.setMainPlayer(cam.toUrl());
          }
          final cameraSide = camera['OUT_SIDE'];
          if (cameraSide != null) {
            player.setSidePlayer(cameraSide.toUrl());
          }
        }
        break;
      default:
        player.stopAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: homeViewModel,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kColorPrimary,
            title: Text(
              homeViewModel.title,
              style: TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SideMenu(
                controller: sideMenu,
                style: SideMenuStyle(
                  displayMode: SideMenuDisplayMode.compact,
                  openSideMenuWidth: 60,
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
                      homeViewModel.setTitleCommand('ทางเข้า');
                      selectedPage('ENTRANCE');
                      sideMenu.changePage(page);
                    },
                    icon: const Icon(Icons.door_front_door_outlined),
                    tooltipContent: "ทางเข้า",
                  ),
                  SideMenuItem(
                    title: 'ทางออก',
                    onTap: (page, _) {
                      homeViewModel.setTitleCommand('ทางออก');
                      selectedPage('EXIT');
                      sideMenu.changePage(page);
                    },
                    icon: const Icon(Icons.door_back_door_outlined),
                    tooltipContent: "ทางออก",
                  ),
                  SideMenuItem(
                    title: 'ผู้ติดต่อ',
                    onTap: (page, _) {
                      homeViewModel.setTitleCommand('รายชื่อผู้ติดต่อ');
                      selectedPage('VISITOR');
                      sideMenu.changePage(page);
                    },
                    icon: const Icon(Icons.badge),
                  ),
                  SideMenuItem(
                    title: 'บันทึกผู้ติดต่อลงทะเบียน',
                    onTap: (page, _) {
                      homeViewModel.setTitleCommand('บันทึกผู้ติดต่อลงทะเบียน');
                      selectedPage('REGISTERED_USER_NOT_CHECK_OUT');
                      sideMenu.changePage(page);
                    },
                    icon: const Icon(Icons.badge),
                  ),
                  SideMenuItem(
                    title: 'บันทึกเข้า-ออก',
                    onTap: (page, _) {
                      homeViewModel.setTitleCommand('บันทึกเข้า-ออก');
                      selectedPage('LOG');
                      sideMenu.changePage(page);
                    },
                    icon: const Icon(Icons.commute),
                  ),
                  SideMenuItem(
                    title: 'สมาชิก',
                    onTap: (page, _) {
                      homeViewModel.setTitleCommand('รายชื่อสมาชิก');
                      selectedPage('MEMBER');
                      sideMenu.changePage(page);
                    },
                    icon: const Icon(Icons.person_search),
                  ),
                  SideMenuItem(
                    title: 'ผู้ติดต่อลงทะเบียน',
                    onTap: (page, _) {
                      homeViewModel.setTitleCommand(
                        'รายชื่อผู้ติดต่อลงทะเบียน',
                      );
                      selectedPage('REGISTERED_USER');
                      sideMenu.changePage(page);
                    },
                    icon: const Icon(Icons.person_search),
                  ),
                  SideMenuItem(
                    title: 'รายงาน',
                    onTap: (page, _) {
                      homeViewModel.setTitleCommand('รายงาน');
                      selectedPage('REPORT');
                      sideMenu.changePage(page);
                    },
                    icon: const Icon(Icons.summarize),
                  ),
                  SideMenuItem(
                    title: 'ตั้งค่า',
                    onTap: (page, _) {
                      homeViewModel.setTitleCommand('ตั้งค่า');
                      selectedPage('SETTING');
                      sideMenu.changePage(page);
                    },
                    icon: const Icon(Icons.settings),
                  ),
                  SideMenuItem(
                    title: 'ผู้ใช้งาน',
                    onTap: (page, _) {
                      homeViewModel.setTitleCommand('รายชื่อผู้ใช้งาน');
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
                      logoutViewModel.logoutCommand.execute();
                    },
                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: page,
                  children: [
                    Container(color: Colors.white, child: EntranceScreen.page),
                    Container(color: Colors.white, child: ExitScreen.page),
                    Container(
                      color: Colors.white,
                      child: const VisitorScreen(),
                    ),
                    Container(
                      color: Colors.white,
                      child: RegisteredUserNotCheckOutScreen.page,
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
                      child: RegisteredUserListScreen.page,
                    ),
                    Container(color: Colors.white, child: const ReportScreen()),
                    Container(
                      color: Colors.white,
                      child: SettingScreen(
                        printerViewModel: getIt<PrinterViewModel>(),
                      ),
                    ),
                    Container(color: Colors.white, child: const UserScreen()),
                    Container(
                      color: Colors.white,
                      child: const Center(
                        child: Text('Exit', style: TextStyle(fontSize: 35)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
