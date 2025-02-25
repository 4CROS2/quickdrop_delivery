import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickdrop_delivery/src/features/active_switch/data/datasource/active_switch_datasource.dart';
import 'package:quickdrop_delivery/src/features/active_switch/data/repository/active_switch_repository_impl.dart';
import 'package:quickdrop_delivery/src/features/active_switch/domain/repository/active_switch_repository.dart';
import 'package:quickdrop_delivery/src/features/active_switch/domain/usecase/switch_status_usecase.dart';
import 'package:quickdrop_delivery/src/features/active_switch/presentation/cubit/active_switch_cubit.dart';
import 'package:quickdrop_delivery/src/features/app/domain/usecase/app_usecase.dart';
import 'package:quickdrop_delivery/src/features/app/presentation/cubit/app_cubit.dart';
import 'package:quickdrop_delivery/src/features/auth/login/data/datasource/auth_datasource.dart';
import 'package:quickdrop_delivery/src/features/auth/login/data/repository/auth_repository_impl.dart';
import 'package:quickdrop_delivery/src/features/auth/login/domain/repository/auth_repository.dart';
import 'package:quickdrop_delivery/src/features/auth/login/domain/usecase/auth_usecase.dart';
import 'package:quickdrop_delivery/src/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:quickdrop_delivery/src/features/delivery_location/cubit/delivery_location_cubit.dart';
import 'package:quickdrop_delivery/src/features/delivery_location/data/datasource/delivery_location_datasource.dart';
import 'package:quickdrop_delivery/src/features/delivery_location/data/repository/delivery_location_repository_impl.dart';
import 'package:quickdrop_delivery/src/features/delivery_location/domain/repository/delivery_location_repository.dart';
import 'package:quickdrop_delivery/src/features/delivery_location/domain/usecase/delivery_location_usecase.dart';
import 'package:quickdrop_delivery/src/features/location/cubit/location_cubit.dart';
import 'package:quickdrop_delivery/src/features/location/data/datasource/location_datasource.dart';
import 'package:quickdrop_delivery/src/features/location/data/repository/location_repository_impl.dart';
import 'package:quickdrop_delivery/src/features/location/domain/repository/location_repository.dart';
import 'package:quickdrop_delivery/src/features/location/domain/usecase/location_usecase.dart';
import 'package:quickdrop_delivery/src/features/orders/data/datasource/orders_datasource.dart';
import 'package:quickdrop_delivery/src/features/orders/data/repository/orders_repository_impl.dart';
import 'package:quickdrop_delivery/src/features/orders/domain/repository/orders_repository.dart';
import 'package:quickdrop_delivery/src/features/orders/domain/usecase/orders_usecase.dart';
import 'package:quickdrop_delivery/src/features/orders/presentation/cubit/orders_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Firebase
  sl.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    ),
  );
  //datasource
  sl.registerLazySingleton<AuthDatasource>(
    () => AuthDatasource(
      googleSigin: sl<GoogleSignIn>(),
    ),
  );
  sl.registerLazySingleton<ActiveSwitchDatasource>(
    () => ActiveSwitchDatasource(),
  );
  sl.registerLazySingleton<OrdersDatasource>(
    () => OrdersDatasource(),
  );
  sl.registerLazySingleton<LocationDatasource>(
    () => LocationDatasource(),
  );
  sl.registerLazySingleton<DeliveryLocationDatasource>(
    () => DeliveryLocationDatasource(),
  );
  //repository
  sl.registerLazySingleton<AuthRepository>(
    () => IAuthRepository(
      datasource: sl<AuthDatasource>(),
    ),
  );
  sl.registerLazySingleton<ActiveSwitchRepository>(
    () => IActiveSwitchRepository(
      datasource: sl<ActiveSwitchDatasource>(),
    ),
  );
  sl.registerLazySingleton<OrdersRepository>(
    () => IOrdersRepository(
      datasource: sl<OrdersDatasource>(),
    ),
  );
  sl.registerLazySingleton<LocationRepository>(
    () => ILocationRepository(
      datasource: sl<LocationDatasource>(),
    ),
  );
  sl.registerLazySingleton<DeliveryLocationRepository>(
    () => IDeliveryLocationRepository(
      datasource: sl<DeliveryLocationDatasource>(),
    ),
  );
  //usecase
  sl.registerLazySingleton<AppUsecase>(
    () => AppUsecase(
      repository: sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(
      repository: sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton<SwitchStatusUsecase>(
    () => SwitchStatusUsecase(
      repository: sl<ActiveSwitchRepository>(),
    ),
  );
  sl.registerLazySingleton<OrdersUsecase>(
    () => OrdersUsecase(
      repository: sl<OrdersRepository>(),
    ),
  );
  sl.registerLazySingleton<LocationUsecase>(
    () => LocationUsecase(
      repository: sl<LocationRepository>(),
    ),
  );
  sl.registerLazySingleton<DeliveryLocationUsecase>(
    () => DeliveryLocationUsecase(
      repository: sl<DeliveryLocationRepository>(),
    ),
  );
  //cubit
  sl.registerFactory<AppCubit>(
    () => AppCubit(
      usecase: sl<AppUsecase>(),
    ),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      authUseCase: sl<AuthUseCase>(),
    ),
  );
  sl.registerLazySingleton<ActiveSwitchCubit>(
    () => ActiveSwitchCubit(
      usecase: sl<SwitchStatusUsecase>(),
    ),
  );
  sl.registerFactory<OrdersCubit>(
    () => OrdersCubit(
      usecase: sl<OrdersUsecase>(),
    ),
  );
  sl.registerLazySingleton<LocationCubit>(
    () => LocationCubit(
      usecase: sl<LocationUsecase>(),
    ),
  );
  sl.registerFactory<DeliveryLocationCubit>(
    () => DeliveryLocationCubit(
      usecase: sl<DeliveryLocationUsecase>(),
    ),
  );
}
