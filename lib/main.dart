import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickdrop_delivery/firebase_options.dart';
import 'package:quickdrop_delivery/src/injection/injection_container.dart'
    as di;
import 'package:quickdrop_delivery/src/presentation/App/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await di.init();
  runApp(
    const App(),
  );
}
