import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:quickdrop_delivery/firebase_options.dart';
import 'package:quickdrop_delivery/src/features/location/cubit/location_cubit.dart';
import 'package:quickdrop_delivery/src/injection/injection_container.dart';
import 'package:quickdrop_delivery/src/injection/injection_container.dart'
    as di;

Future<void> initializeBackground() async {
  final FlutterBackgroundService service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
    ),
  );
  await service.startService();
}

@pragma('vm:entry-point')
bool onIosBackground(ServiceInstance service) {
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (service is AndroidServiceInstance) {
    await service.setForegroundNotificationInfo(
      title: 'Seguimiento de Ubicación',
      content: 'La ubicación se está rastreando en segundo plano.',
    );
  }
  _startTracking();
}

void _startTracking() async {
  final LocationCubit locationCubit = sl<LocationCubit>();
  await locationCubit.getLocation();
}
