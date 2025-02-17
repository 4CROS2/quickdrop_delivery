import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickdrop_delivery/src/data/datasource/active_switch_datasource.dart';
import 'package:quickdrop_delivery/src/data/datasource/firebase_auth_datasource.dart';
import 'package:quickdrop_delivery/src/data/datasource/orders_datasource.dart';
import 'package:quickdrop_delivery/src/data/repository/active_switch_repository_impl.dart';
import 'package:quickdrop_delivery/src/data/repository/auth_repository_impl.dart';
import 'package:quickdrop_delivery/src/data/repository/orders_repository_impl.dart';
import 'package:quickdrop_delivery/src/domain/repository/active_switch_repository.dart';
import 'package:quickdrop_delivery/src/domain/repository/auth_repository.dart';
import 'package:quickdrop_delivery/src/domain/repository/orders_repository.dart';
import 'package:quickdrop_delivery/src/domain/usecase/auth_usecase.dart';
import 'package:quickdrop_delivery/src/domain/usecase/orders_usecase.dart';
import 'package:quickdrop_delivery/src/domain/usecase/switch_status_usecase.dart';
import 'package:quickdrop_delivery/src/presentation/App/cubit/app_cubit.dart';
import 'package:quickdrop_delivery/src/presentation/home/widgets/active_switch/cubit/active_switch_cubit.dart';
import 'package:quickdrop_delivery/src/presentation/home/widgets/orders/cubit/orders_cubit.dart';
import 'package:quickdrop_delivery/src/presentation/login/cubit/login_cubit.dart';

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
  sl.registerLazySingleton<FirebaseAuthDatasource>(
    () => FirebaseAuthDatasource(
      googleSigin: sl<GoogleSignIn>(),
    ),
  );
  sl.registerLazySingleton<ActiveSwitchDatasource>(
    () => ActiveSwitchDatasource(),
  );
  sl.registerLazySingleton<OrdersDatasource>(
    () => OrdersDatasource(),
  );
  //repository
  sl.registerLazySingleton<AuthRepository>(
    () => IAuthRepository(
      datasource: sl<FirebaseAuthDatasource>(),
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
  //usecase
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
  //cubit
  sl.registerFactory<AppCubit>(
    () => AppCubit(
      usecase: sl<AuthUseCase>(),
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
}
