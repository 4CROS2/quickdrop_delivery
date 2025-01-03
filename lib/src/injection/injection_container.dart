import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickdrop_delivery/src/data/datasource/firebase_auth_datasource.dart';
import 'package:quickdrop_delivery/src/data/repository/auth_repository_impl.dart';
import 'package:quickdrop_delivery/src/domain/repository/auth_repository.dart';
import 'package:quickdrop_delivery/src/domain/usecase/auth_usecase.dart';
import 'package:quickdrop_delivery/src/presentation/App/cubit/app_cubit.dart';
import 'package:quickdrop_delivery/src/presentation/login/cubit/login_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  sl.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  sl.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    ),
  );
  //datasource
  sl.registerLazySingleton<FirebaseAuthDatasource>(
    () => FirebaseAuthDatasource(
      firebaseAuth: sl<FirebaseAuth>(),
      firestore: sl<FirebaseFirestore>(),
      googleSigin: sl<GoogleSignIn>(),
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
      usecase: sl<AuthUseCase>(),
    ),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      authUseCase: sl<AuthUseCase>(),
    ),
  );
}
