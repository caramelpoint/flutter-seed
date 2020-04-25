import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/authorization/token_manager.dart';
import 'core/config/env_config.dart';
import 'core/network/network_info.dart';
import 'features/authentication/data/datasources/user_remote_data_source.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/data/repositories/user_session_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/repositories/user_session_repository.dart';
import 'features/authentication/domain/usecases/login/login_bloc.dart';
import 'features/authentication/domain/usecases/user_session/bloc.dart';
import 'features/item_list/data/datasources/item_remote_data_source.dart';
import 'features/item_list/data/repositories/item_repository_impl.dart';
import 'features/item_list/domain/repositories/item_repository.dart';
import 'features/item_list/domain/usecases/get_all_items/get_all_items_bloc.dart';

final GetIt injector = GetIt.instance;

Future<void> init() async {
  //! Features - Authentication
  // Bloc
  injector.registerFactory(
    () => LoginBloc(
      authRepository: injector<AuthRepository>(),
      userSessionRepository: injector<UserSessionRepository>(),
    ),
  );
  injector.registerFactory(
    () => UserSessionBloc(
      userSessionRepository: injector<UserSessionRepository>(),
    ),
  );

  // Repository
  injector.registerLazySingleton<UserSessionRepository>(
    () => UserSessionRepositoryImpl(
      sharedPreferences: injector<SharedPreferences>(),
    ),
  );
  injector.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkInfo: injector<NetworkInfo>(),
      remoteDataSource: injector<UserRemoteDataSource>(),
    ),
  );

  // Data sources
  injector.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      envConfig: injector<EnvConfig>(),
      tokenManager: injector<TokenManager>(),
      client: injector<http.Client>(),
    ),
  );

  //! Features - Items
  // Bloc
  injector.registerFactory(
    () => GetAllItemsBloc(
      repository: injector<ItemRepository>(),
    ),
  );
  // Repository
  injector.registerLazySingleton<ItemRepository>(
    () => ItemRepositoryImpl(
      networkInfo: injector<NetworkInfo>(),
      remoteDataSource: injector<ItemRemoteDataSource>(),
    ),
  );
  // Data sources
  injector.registerLazySingleton<ItemRemoteDataSource>(
    () => ItemRemoteDataSourceImpl(
      envConfig: injector<EnvConfig>(),
      tokenManager: injector<TokenManager>(),
      client: injector<http.Client>(),
    ),
  );

  //! Core
  injector.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      injector<DataConnectionChecker>(),
    ),
  );

  injector.registerLazySingleton<TokenManager>(
    () => TokenManagerImpl(
      sharedPreferences: injector<SharedPreferences>(),
    ),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  injector.registerLazySingleton(() => sharedPreferences);
  injector.registerLazySingleton(() => http.Client());
  injector.registerLazySingleton(() => DataConnectionChecker());
}
