import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:quickdrop_delivery/firebase_options.dart';
import 'package:quickdrop_delivery/src/features/app/presentation/app.dart';
import 'package:quickdrop_delivery/src/injection/injection_container.dart'
    as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /* SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  ); */
  await di.init();
  //await initializeBackground();
  runApp(
    const App(),
  );
}
