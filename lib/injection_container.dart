// lib/injection_container.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/get_current_user.dart';
import 'domain/usecases/sign_in.dart';
import 'domain/usecases/sign_out.dart';
import 'domain/usecases/sign_up.dart';
import 'presentation/bloc/auth/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Firebase
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);

  // DataSources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));

  // BLoCs
  sl.registerFactory(
    () => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      signOutUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );
}
