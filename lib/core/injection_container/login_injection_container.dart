import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../../Features/login/data/data_sources/login_remote_data_source.dart';
import '../../Features/login/data/repositories/login_repository_impl.dart';
import '../../Features/login/domain/repositories/login_repository.dart';
import '../../Features/login/domain/use_cases/send_data_login.dart';
import '../../Features/login/presentation/bloc/login_bloc.dart';
import '../network/network_info.dart';
import '../util/Login_input.dart';


final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => LoginBloc(
      getAnswer: sl(),
      inputUsername: sl(),
      inputPassword: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAnswer(sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(client: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputUsername());
  sl.registerLazySingleton(() => InputPassword());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
