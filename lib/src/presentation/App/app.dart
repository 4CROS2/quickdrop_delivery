import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quickdrop_delivery/src/core/constants/constants.dart';
import 'package:quickdrop_delivery/src/injection/injection_container.dart';
import 'package:quickdrop_delivery/src/presentation/App/cubit/app_cubit.dart';
import 'package:quickdrop_delivery/src/presentation/home/home.dart';
import 'package:quickdrop_delivery/src/presentation/loading/loading.dart';
import 'package:quickdrop_delivery/src/presentation/login/login.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (BuildContext context) => sl<AppCubit>(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, AppState state) {
          return MediaQuery(
            data: MediaQueryData.fromView(View.of(context)).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: MaterialApp(
              title: 'Quickdrop Delivery',
              theme: ThemeData(
                colorSchemeSeed: Constants.primaryColor,
                fontFamily: 'RedHat',
              ),
              locale: Locale(
                View.of(context).platformDispatcher.locale.languageCode,
              ),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const <LocalizationsDelegate<Object>>[
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: Scaffold(
                body: AnimatedSwitcher(
                  duration: Constants.animationTransition,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: switch (state.appStatus) {
                    AppStatus.authenticated => const Home(),
                    AppStatus.unauthenticated => const Login(),
                    AppStatus.loading => const LoadingPage()
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
