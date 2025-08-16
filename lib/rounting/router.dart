import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../features/member/presentation/bloc/member_list/member_list_bloc.dart';
import '../features/member/presentation/page/member_screen.dart';
import '../features/registered_user/presentation/page/registered_user_logs_screen.dart';
import '../injector/injector.dart';
import '../screens/main_screen.dart';
import '../screens/visitor_detail_screen.dart';
import '../screens/welcome_screen.dart';
import '../ui/auth/login/view_models/login_viewmodel.dart';
import '../ui/auth/login/widgets/login_screen.dart';
import '../ui/auth/logout/view_models/logout_viewmodel.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: MainScreen.routeName,
  debugLogDiagnostics: true,
  redirect: _redirect,
  refreshListenable: authRepository,
  routes: [
    GoRoute(
      path: WelcomeScreen.routeName,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => LoginScreen(
        loginViewModel: LoginViewModel(authRepository: context.read()),
      ),
    ),
    GoRoute(
      path: MainScreen.routeName,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<MemberListBloc>(),
        child: MainScreen(
          logoutViewModel: LogoutViewModel(authRepository: context.read()),
        ),
      ),
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

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  // if the user is not logged in, they need to login
  final loggedIn = await context.read<AuthRepository>().isAuthenticated;
  final loggingIn = state.matchedLocation == LoginScreen.routeName;
  if (!loggedIn) {
    return LoginScreen.routeName;
  }

  // if the user is logged in but still on the login page, send them to
  // the home page
  if (loggingIn) {
    return MainScreen.routeName;
  }

  // no need to redirect at all
  return null;
}
