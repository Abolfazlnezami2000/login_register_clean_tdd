import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../Features/register/data/data_sources/register_remote_data_source.dart';
import '../../Features/register/data/repositories/register_repository_impl.dart';
import '../../Features/register/domain/repositories/register_repository.dart';
import '../../Features/register/domain/use_cases/send_data_register.dart';
import '../../Features/register/presentation/bloc/register_bloc.dart';
import '../network/network_info.dart';
import '../util/register_input.dart';



final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => RegisterBloc(
      getAnswer: sl(),
      inputUsername: sl(),
      inputPassword: sl(),
      inputPhoneNumber: sl(),
      inputEmail: sl(),
      inputName: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAnswer(sl()));

  // Repository
  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<RegisterRemoteDataSource>(
    () => RegisterRemoteDataSourceImpl(client: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputUsername());
  sl.registerLazySingleton(() => InputPassword());
  sl.registerLazySingleton(() => InputPhoneNumber());
  sl.registerLazySingleton(() => InputEmail());
  sl.registerLazySingleton(() => InputName());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
