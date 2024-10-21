import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quickdrop_delivery/src/presentation/home/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
       data: MediaQueryData.fromView(View.of(context)).copyWith(
        textScaler: const TextScaler.linear(1.0),
      ),
      child: MaterialApp(
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
        home: Home(),
      ),
    );
  }
}
