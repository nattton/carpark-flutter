import 'package:carpark/data/repositories/auth/auth_repository.dart';
import 'package:carpark/injector/injector.dart';
import 'package:carpark/rounting/routes.dart';
import 'package:carpark/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:carpark/ui/auth/login/widgets/login_screen.dart';
import 'package:carpark/ui/auth/logout/view_models/logout_viewmodel.dart';
import 'package:carpark/ui/home/view_models/home_viewmodel.dart';
import 'package:carpark/ui/home/widgets/home_screen.dart';
import 'package:carpark/ui/member/bloc/member_list/member_list_bloc.dart';
import 'package:carpark/ui/member/widgets/member_screen.dart';
import 'package:carpark/ui/registered_user/widgets/page/registered_user_logs_screen.dart';
import 'package:carpark/ui/visitor/widgets/visitor_detail_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  redirect: _redirect,
  refreshListenable: authRepository,
  routes: [
    GoRoute(
      path: Routes.login,
      pageBuilder: (context, state) => NoTransitionPage(
        child: LoginScreen(loginViewModel: getIt<LoginViewModel>()),
      ),
    ),
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) => NoTransitionPage(
        child: BlocProvider(
          create: (context) => getIt<MemberListBloc>(),
          child: HomeScreen(
            homeViewModel: getIt<HomeViewModel>(),
            logoutViewModel: getIt<LogoutViewModel>(),
          ),
        ),
      ),
    ),
    GoRoute(
      path: Routes.member,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: MemberScreen(
          memberId: 0,
        ),
      ),
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
  // if the user is not logged in, they need to login
  final loggedIn = await getIt<AuthRepository>().isAuthenticated;
  final loggingIn = state.matchedLocation == Routes.login;
  if (!loggedIn) {
    return Routes.login;
  }

  // if the user is logged in but still on the login page, send them to
  // the home page
  if (loggingIn) {
    return Routes.home;
  }

  // no need to redirect at all
  return null;
}
