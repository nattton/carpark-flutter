import 'package:carpark/config/injector.dart';
import 'package:carpark/data/repositories/auth/auth_repository.dart';
import 'package:carpark/routing/routes.dart';
import 'package:carpark/ui/features/auth/login/views/login_screen.dart';
import 'package:carpark/ui/features/home/views/home_screen.dart';
import 'package:carpark/ui/features/member/views/member_screen.dart';
import 'package:carpark/ui/features/registered_user/views/page/registered_user_logs_screen.dart';
import 'package:carpark/ui/features/visitor/views/visitor_detail_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  redirect: _redirect,
  refreshListenable: authRepository,
  routes: [
    GoRoute(
      path: Routes.login,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: LoginScreen()),
    ),
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeScreen()),
    ),
    GoRoute(
      path: Routes.member,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: MemberScreen(memberId: 0)),
    ),
    GoRoute(
      path: '${Routes.member}/:memberId',
      pageBuilder: (context, state) => NoTransitionPage(
        child: MemberScreen(
          memberId: int.parse(state.pathParameters['memberId'] ?? '0'),
        ),
      ),
    ),
    GoRoute(
      path: '${Routes.visitorDetail}/:visitorId',
      pageBuilder: (context, state) => NoTransitionPage(
        child: VisitorDetailScreen(
          visitorId: int.parse(state.pathParameters['visitorId'] ?? '0'),
        ),
      ),
    ),
    GoRoute(
      path: '${Routes.registeredUserLogs}/:userId',
      pageBuilder: (context, state) => NoTransitionPage(
        child: RegisteredUserLogsScreen.page(
          userId: int.parse(state.pathParameters['userId'] ?? '0'),
        ),
      ),
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final loggedIn = await getIt<AuthRepository>().isAuthenticated;
  final loggingIn = state.matchedLocation == Routes.login;
  if (!loggedIn) {
    return Routes.login;
  }

  if (loggingIn) {
    return Routes.home;
  }

  return null;
}
