import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:quickdrop_delivery/src/data/datasource/firebase_auth_datasource.dart';
import 'package:quickdrop_delivery/src/data/repository/auth_repository_impl.dart';
import 'package:quickdrop_delivery/src/domain/repository/auth_repository.dart';
import 'package:quickdrop_delivery/src/domain/usecase/auth_usecase.dart';
import 'package:quickdrop_delivery/src/presentation/App/cubit/app_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  sl.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  //datasource
  sl.registerLazySingleton<FirebaseAuthDatasource>(
    () => FirebaseAuthDatasource(
      firebaseAuth: sl<FirebaseAuth>(),
      firestore: sl<FirebaseFirestore>(),
    ),
  );
  //repository
  sl.registerLazySingleton<AuthRepository>(
    () => IAuthRepository(
      datasource: sl<FirebaseAuthDatasource>(),
    ),
  );
  //usecase
  sl.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(
      repository: sl<AuthRepository>(),
    ),
  );
  //cubit
  sl.registerFactory<AppCubit>(
    () => AppCubit(
      firebasAuth: sl<FirebaseAuth>(),
    ),
  );
}
