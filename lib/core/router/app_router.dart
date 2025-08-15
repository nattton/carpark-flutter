import 'package:go_router/go_router.dart';

import '../../features/member/presentation/page/member_screen.dart';
import '../../features/registered_user/presentation/page/registered_user_logs_screen.dart';
import '../../screens/login_screen.dart';
import '../../screens/main_screen.dart';
import '../../screens/visitor_detail_screen.dart';
import '../../screens/welcome_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: WelcomeScreen.routeName,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: MainScreen.routeName,
      builder: (context, state) => MainScreen.page,
    ),
    GoRoute(
      path: '${MemberScreen.routeName}/:memberId',
      builder: (context, state) => MemberScreen(
        memberId: int.parse(state.pathParameters['memberId'] ?? '0'),
      ),
    ),
    GoRoute(
      path: '${VisitorDetailScreen.routeName}/:visitorId',
      builder: (context, state) => VisitorDetailScreen(
        visitorId: int.parse(state.pathParameters['visitorId'] ?? '0'),
      ),
    ),
    GoRoute(
      path: '${RegisteredUserLogsScreen.routeName}/:userId',
      builder: (context, state) => RegisteredUserLogsScreen.page(
        userId: int.parse(state.pathParameters['userId'] ?? '0'),
      ),
    ),
  ],
);
