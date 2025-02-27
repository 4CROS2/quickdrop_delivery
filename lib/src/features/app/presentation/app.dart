import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quickdrop_delivery/src/core/Theme/theme.dart';
import 'package:quickdrop_delivery/src/core/generated/app_localizations.dart';
import 'package:quickdrop_delivery/src/core/router/router.dart';
import 'package:quickdrop_delivery/src/features/active_switch/presentation/cubit/active_switch_cubit.dart';
import 'package:quickdrop_delivery/src/features/app/presentation/cubit/app_cubit.dart';
import 'package:quickdrop_delivery/src/features/location/cubit/location_cubit.dart';
import 'package:quickdrop_delivery/src/injection/injection_container.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late final AppRouter _appRouter;
  bool isDark = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _appRouter = AppRouter();
  }

  bool get _deviceThemeDarkMode {
    final Brightness brightness =
        View.of(context).platformDispatcher.platformBrightness;
    final bool brState = brightness == Brightness.dark;
    return brState;
  }

  @override
  void didChangeDependencies() {
    _initializeTheme(context);
    super.didChangeDependencies();
  }

  @override
  void didChangePlatformBrightness() {
    _initializeTheme(context);
    setState(() {});
    super.didChangePlatformBrightness();
  }

  void _initializeTheme(BuildContext context) {
    AppTheme.initialize(
      context,
      isDarkMode: _deviceThemeDarkMode,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<Object?>>[
        BlocProvider<AppCubit>(
          create: (BuildContext context) => sl<AppCubit>(),
        ),
        BlocProvider<ActiveSwitchCubit>(
          create: (BuildContext context) => sl<ActiveSwitchCubit>(),
        ),
        BlocProvider<LocationCubit>(
          create: (BuildContext context) => sl<LocationCubit>(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, AppState state) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: MaterialApp.router(
              title: 'Quickdrop Delivery',
              theme: AppTheme.instance,
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
              routerConfig: _appRouter.router,
            ),
          );
        },
      ),
    );
  }
}
