import 'dart:async';
import 'dart:io';

import 'package:carpark/config/app_config_provider.dart';
import 'package:carpark/config/constants.dart';
import 'package:carpark/data/services/api/api_service.dart';
import 'package:carpark/features/gateway/presentation/page/entrance_screen.dart';
import 'package:carpark/features/gateway/presentation/page/exit_screen.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/models/models.dart';
import 'package:carpark/ui/auth/logout/view_models/logout_viewmodel.dart';
import 'package:carpark/ui/gate_log/widgets/gate_log_screen.dart';
import 'package:carpark/ui/home/view_models/home_viewmodel.dart';
import 'package:carpark/ui/live_player/view_models/live_player_viewmodel.dart';
import 'package:carpark/ui/member/widgets/member_list_screen.dart';
import 'package:carpark/ui/registered_user/widgets/page/registered_user_list_screen.dart';
import 'package:carpark/ui/registered_user/widgets/page/registered_user_not_check_out_screen.dart';
import 'package:carpark/ui/report/widgets/report_screen.dart';
import 'package:carpark/ui/setting/printer/view_models/printer_viewmodel.dart';
import 'package:carpark/ui/setting/widgets/setting_screen.dart';
import 'package:carpark/ui/user/widgets/user_screen.dart';
import 'package:carpark/ui/visitor/widgets/visitor_screen.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final lastGateProvider = StateNotifierProvider<LastGateNotifier, LastGate>(
  (ref) => LastGateNotifier(
    LastGate(gateIn: GateLogModel(0), gateOut: GateLogModel(0)),
  ),
);

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({
    required this.homeViewModel,
    required this.logoutViewModel,
    super.key,
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

  late WebSocket channel;

  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  String getWsUrl() {
    final currentHost = AppConfigProvider().getCurrentHost();
    return '$currentHost/ws'.replaceAll('http', 'ws');
  }

  Future<void> initWebSocketChannelConnection() async {
    final lastGate = ref.read(lastGateProvider.notifier);
    final channel = WebSocketChannel.connect(Uri.parse(getWsUrl()));
    channel.stream.listen((streamData) {
      _log.info(streamData);
      lastGate.setFromJson(streamData as String);
    });
  }

  Future<void> initWebSocketConnection() async {
    _log.info('conecting...');
    channel = await connectWs();
    _log.info('socket connection initializied');
    await channel.done.then((dynamic _) => _onDisconnected());
    broadcastNotifications();
  }

  void broadcastNotifications() {
    final lastGate = ref.read(lastGateProvider.notifier);
    channel.listen(
      (streamData) {
        _log.info(streamData);
        lastGate.setFromJson(streamData as String);
      },
      onDone: () {
        _log.info('conecting aborted');
        initWebSocketConnection();
      },
      onError: (Exception e) {
        _log.info('Server error: $e');
        initWebSocketConnection();
      },
    );
  }

  Future<WebSocket> connectWs() async {
    try {
      return await WebSocket.connect(getWsUrl());
    } on Exception catch (e) {
      _log.warning('Error! can not connect WS connectWs $e');
      await Future<void>.delayed(const Duration(milliseconds: 5000));
      return connectWs();
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

    if (!kIsWeb) {
      getIt<LivePlayerViewmodel>().getCameraCommand.run();
    }

    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
  }

  void alertError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> getLastGate() async {
    final lastGate = ref.read(lastGateProvider.notifier);
    try {
      final result = await getIt<ApiService>().getLastGate();
      lastGate
        ..setGateIn(result.gateIn)
        ..setGateOut(result.gateOut);
    } on Exception catch (e) {
      alertError(e.toString());
    }
  }

  Future<void> getLastGateIn() async {
    final lastGate = ref.read(lastGateProvider.notifier);
    try {
      final result = await getIt<ApiService>().getGateIn();
      lastGate.setGateIn(result.gateLog);
    } on Exception catch (e) {
      alertError(e.toString());
    }
  }

  Future<void> getLastGateOut() async {
    final lastGate = ref.read(lastGateProvider.notifier);
    try {
      final result = await getIt<ApiService>().getGateOut();
      lastGate.setGateOut(result.gateLog);
    } on Exception catch (e) {
      alertError(e.toString());
    }
  }

  void selectedPage(String page) {
    switch (page) {
      case 'ENTRANCE':
        getLastGateIn();
        if (!kIsWeb) {
          getIt<LivePlayerViewmodel>().playEntranceCommand.run();
        }
      case 'EXIT':
        getLastGateOut();
        if (!kIsWeb) {
          getIt<LivePlayerViewmodel>().playExitCommand.run();
        }
      default:
        if (!kIsWeb) {
          getIt<LivePlayerViewmodel>().stopAllCommand.run();
        }
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
              style: const TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Row(
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
                    tooltipContent: 'ทางเข้า',
                  ),
                  SideMenuItem(
                    title: 'ทางออก',
                    onTap: (page, _) {
                      homeViewModel.setTitleCommand('ทางออก');
                      selectedPage('EXIT');
                      sideMenu.changePage(page);
                    },
                    icon: const Icon(Icons.door_back_door_outlined),
                    tooltipContent: 'ทางออก',
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
                      logoutViewModel.logoutCommand.run();
                    },
                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: page,
                  children: [
                    ColoredBox(color: Colors.white, child: EntranceScreen.page),
                    ColoredBox(color: Colors.white, child: ExitScreen.page),
                    const ColoredBox(
                      color: Colors.white,
                      child: VisitorScreen(),
                    ),
                    ColoredBox(
                      color: Colors.white,
                      child: RegisteredUserNotCheckOutScreen.page,
                    ),
                    const ColoredBox(
                      color: Colors.white,
                      child: GateLogScreen(),
                    ),
                    const ColoredBox(
                      color: Colors.white,
                      child: MemberListScreen(),
                    ),
                    ColoredBox(
                      color: Colors.white,
                      child: RegisteredUserListScreen.page,
                    ),
                    const ColoredBox(
                      color: Colors.white,
                      child: ReportScreen(),
                    ),
                    ColoredBox(
                      color: Colors.white,
                      child: SettingScreen(
                        printerViewModel: getIt<PrinterViewModel>(),
                      ),
                    ),
                    const ColoredBox(color: Colors.white, child: UserScreen()),
                    const ColoredBox(
                      color: Colors.white,
                      child: Center(
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
