import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../features/member/presentation/bloc/member_list/member_list_bloc.dart';
import '../features/member/presentation/page/member_screen.dart';
import '../features/registered_user/presentation/page/registered_user_logs_screen.dart';
import '../injector/injector.dart';
import '../rounting/routes.dart';
import '../screens/home_screen.dart';
import '../screens/visitor_detail_screen.dart';
import '../ui/auth/login/view_models/login_viewmodel.dart';
import '../ui/auth/login/widgets/login_screen.dart';
import '../ui/auth/logout/view_models/logout_viewmodel.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  redirect: _redirect,
  refreshListenable: authRepository,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => LoginScreen(
        loginViewModel: LoginViewModel(authRepository: context.read()),
      ),
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<MemberListBloc>(),
        child: HomeScreen(
          logoutViewModel: LogoutViewModel(authRepository: context.read()),
        ),
      ),
    ),
    GoRoute(
      path: '${Routes.member}/:memberId',
      builder: (context, state) => MemberScreen(
        memberId: int.parse(state.pathParameters['memberId'] ?? '0'),
      ),
    ),
    GoRoute(
      path: '${Routes.visitorDetail}/:visitorId',
      builder: (context, state) => VisitorDetailScreen(
        visitorId: int.parse(state.pathParameters['visitorId'] ?? '0'),
      ),
    ),
    GoRoute(
      path: '${Routes.registeredUserLogs}/:userId',
      builder: (context, state) => RegisteredUserLogsScreen.page(
        userId: int.parse(state.pathParameters['userId'] ?? '0'),
      ),
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  // if the user is not logged in, they need to login
  final loggedIn = await context.read<AuthRepository>().isAuthenticated;
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
