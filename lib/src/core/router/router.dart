import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_delivery/src/core/router/listener.dart';
import 'package:quickdrop_delivery/src/features/auth/login/presentation/login.dart';
import 'package:quickdrop_delivery/src/injection/injection_container.dart';
import 'package:quickdrop_delivery/src/features/app/presentation/cubit/app_cubit.dart';
import 'package:quickdrop_delivery/src/features/home/home.dart';
import 'package:quickdrop_delivery/src/features/loading/loading.dart';

class AppRouter {
  final AppCubit _appCubit = sl<AppCubit>();
  late final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoListener(stream: _appCubit.stream),
    redirect: (BuildContext context, GoRouterState state) {
      final AppStatus appStatus = _appCubit.state.appStatus;
      final String currentLocation = state.matchedLocation;
      final bool isAuthenticated = appStatus == AppStatus.authenticated;
      final bool isUnAuthenticated = appStatus == AppStatus.unauthenticated;
      if (isUnAuthenticated && currentLocation != '/login') {
        return '/login';
      }

      if (isAuthenticated && currentLocation == '/') {
        return '/home';
      }

      if (isAuthenticated &&
          <String>[
            '/login',
          ].contains(currentLocation)) {
        return '/home';
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage<LoadingPage>(child: LoadingPage());
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) => Login(),
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) => Home(),
      ),
    ],
  );
}
