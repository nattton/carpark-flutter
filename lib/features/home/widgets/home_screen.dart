import 'dart:async';
import 'dart:io';

import 'package:carpark/features/auth/logout/view_models/logout_viewmodel.dart';
import 'package:carpark/features/gate_log/widgets/gate_log_screen.dart';
import 'package:carpark/features/gateway/widgets/entrance_screen.dart';
import 'package:carpark/features/gateway/widgets/exit_screen.dart';
import 'package:carpark/features/home/view_models/home_viewmodel.dart';
import 'package:carpark/features/home/view_models/late_gate_viewmodel.dart';
import 'package:carpark/features/live_player/view_models/live_player_viewmodel.dart';
import 'package:carpark/features/member/widgets/member_list_screen.dart';
import 'package:carpark/features/registered_user/widgets/page/registered_user_list_screen.dart';
import 'package:carpark/features/registered_user/widgets/page/registered_user_not_check_out_screen.dart';
import 'package:carpark/features/report/widgets/report_screen.dart';
import 'package:carpark/features/setting/printer/view_models/printer_viewmodel.dart';
import 'package:carpark/features/setting/widgets/setting_screen.dart';
import 'package:carpark/features/user/widgets/user_screen.dart';
import 'package:carpark/features/visitor/widgets/visitor_screen.dart';
import 'package:carpark/shared/config/app_config_provider.dart';
import 'package:carpark/shared/config/constants.dart';
import 'package:carpark/shared/injector/injector.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeScreen extends WatchingStatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _log = Logger('HomeScreen');
  HomeViewModel get homeViewModel => getIt<HomeViewModel>();
  LogoutViewModel get logoutViewModel => getIt<LogoutViewModel>();

  late WebSocket channel;

  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  String getWsUrl() {
    final currentHost = AppConfigProvider().getCurrentHost();
    return '$currentHost/ws'.replaceAll('http', 'ws');
  }

  Future<void> initWebSocketChannelConnection() async {
    final channel = WebSocketChannel.connect(Uri.parse(getWsUrl()));
    channel.stream.listen((streamData) {
      _log.info(streamData);
      getIt<LastGateViewmodel>().setLastGateFromJsonCommand.run(
        streamData as String,
      );
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
    channel.listen(
      (streamData) {
        _log.info(streamData);
        getIt<LastGateViewmodel>().setLastGateFromJsonCommand.run(
          streamData as String,
        );
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

    sideMenu.addListener(() {
      page.jumpToPage(sideMenu.currentIndex);
    });
  }

  void selectedPage(String page) {
    switch (page) {
      case 'ENTRANCE':
        getIt<LastGateViewmodel>().getGateInCommand.run();
        if (!kIsWeb) {
          getIt<LivePlayerViewmodel>().playEntranceCommand.run();
        }
      case 'EXIT':
        getIt<LastGateViewmodel>().getGateOutCommand.run();
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
    callOnce((_) => getIt<LastGateViewmodel>().getLastGateCommand.run());
    if (!kIsWeb) {
      callOnce((_) => getIt<LivePlayerViewmodel>().getCameraCommand.run());
    }

    final title = watchValue((HomeViewModel viewModel) => viewModel.title);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kColorPrimary,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          SideMenu(
            controller: sideMenu,
            theme: const SideMenuThemeData(
              displayMode: SideMenuDisplayMode.compact,
              openWidth: 60,
              compactWidth: 60,
              hoverColor: Colors.blue,
              selectedColor: Colors.lightBlue,
              selectedTitleStyle: TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
            ),
            items: [
              SideMenuItem(
                title: 'ทางเข้า',
                onTap: (page, _) {
                  homeViewModel.setTitleCommand('ทางเข้า');
                  selectedPage('ENTRANCE');
                  sideMenu.goTo(page);
                },
                icon: const Icon(Icons.door_front_door_outlined),
                tooltipContent: 'ทางเข้า',
              ),
              SideMenuItem(
                title: 'ทางออก',
                onTap: (page, _) {
                  homeViewModel.setTitleCommand('ทางออก');
                  selectedPage('EXIT');
                  sideMenu.goTo(page);
                },
                icon: const Icon(Icons.door_back_door_outlined),
                tooltipContent: 'ทางออก',
              ),
              SideMenuItem(
                title: 'ผู้ติดต่อ',
                onTap: (page, _) {
                  homeViewModel.setTitleCommand('รายชื่อผู้ติดต่อ');
                  selectedPage('VISITOR');
                  sideMenu.goTo(page);
                },
                icon: const Icon(Icons.badge),
              ),
              SideMenuItem(
                title: 'บันทึกผู้ติดต่อลงทะเบียน',
                onTap: (page, _) {
                  homeViewModel.setTitleCommand('บันทึกผู้ติดต่อลงทะเบียน');
                  selectedPage('REGISTERED_USER_NOT_CHECK_OUT');
                  sideMenu.goTo(page);
                },
                icon: const Icon(Icons.badge),
              ),
              SideMenuItem(
                title: 'บันทึกเข้า-ออก',
                onTap: (page, _) {
                  homeViewModel.setTitleCommand('บันทึกเข้า-ออก');
                  selectedPage('LOG');
                  sideMenu.goTo(page);
                },
                icon: const Icon(Icons.commute),
              ),
              SideMenuItem(
                title: 'สมาชิก',
                onTap: (page, _) {
                  homeViewModel.setTitleCommand('รายชื่อสมาชิก');
                  selectedPage('MEMBER');
                  sideMenu.goTo(page);
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
                  sideMenu.goTo(page);
                },
                icon: const Icon(Icons.person_search),
              ),
              SideMenuItem(
                title: 'รายงาน',
                onTap: (page, _) {
                  homeViewModel.setTitleCommand('รายงาน');
                  selectedPage('REPORT');
                  sideMenu.goTo(page);
                },
                icon: const Icon(Icons.summarize),
              ),
              SideMenuItem(
                title: 'ตั้งค่า',
                onTap: (page, _) {
                  homeViewModel.setTitleCommand('ตั้งค่า');
                  selectedPage('SETTING');
                  sideMenu.goTo(page);
                },
                icon: const Icon(Icons.settings),
              ),
              SideMenuItem(
                title: 'ผู้ใช้งาน',
                onTap: (page, _) {
                  homeViewModel.setTitleCommand('รายชื่อผู้ใช้งาน');
                  selectedPage('USER');
                  sideMenu.goTo(page);
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
                const ColoredBox(color: Colors.white, child: EntranceScreen()),
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
  }
}
