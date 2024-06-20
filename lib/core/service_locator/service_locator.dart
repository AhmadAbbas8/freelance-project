import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:grad_project/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:grad_project/modules/auth/data/auth_remote_data_source.dart';
import 'package:grad_project/modules/auth/data/auth_repo.dart';
import 'package:grad_project/modules/home_customer/data/home_customer_remote_data_source.dart';
import 'package:grad_project/modules/home_customer/data/home_customer_repo.dart';
import 'package:grad_project/modules/home_customer/logic/home_customer_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cache_helper/cache_storage.dart';
import '../cache_helper/shared_prefs_cache.dart';
import '../helpers/snackbars/snackbars.dart';
import '../helpers/snackbars/top_snackbars.dart';
import '../network/api/api_consumer.dart';
import '../network/api/dio_consumer.dart';
import '../network/network_info.dart';
import '../utils/end_points.dart';

class ServiceLocator {
  ServiceLocator._();

  static final instance = GetIt.instance;

  static Future<void> setup() async {
    // * Core
    var prefs = await SharedPreferences.getInstance();
    instance.registerLazySingleton<CacheStorage>(() => SharedPrefsCache(prefs));

    instance.registerLazySingleton<NetworkInfo>(
        () => NetWorkInfoImpl(InternetConnectionChecker.createInstance()));
    instance.registerLazySingleton<ApiConsumer>(() => DioConsumer(
            dio: Dio(BaseOptions(
          baseUrl: EndPoints.BASE_URL,
          validateStatus: (status) => status == 200,
          headers: {
            'Content-Type': 'application/json',
          },
        ))));
    instance.registerLazySingleton<SnackBars>(() => TopSnackBars());

    // * BloC/Cubit
    instance.registerFactory<AuthCubit>(() => AuthCubit(authRepo: instance()));
    instance.registerFactory<HomeCustomerCubit>(() => HomeCustomerCubit(
          cacheStorage: instance(),
          homeCustomerRepo: instance(),
        ));

    // * DataSources
    instance.registerLazySingleton<AuthRemoteDataSource>(() =>
        AuthRemoteDataSource(
            apiConsumer: instance(), cacheStorage: instance()));
    instance.registerLazySingleton<HomeCustomerRemoteDataSource>(
        () => HomeCustomerRemoteDataSource(apiConsumer: instance()));

    // * Repository
    instance.registerLazySingleton<AuthRepo>(() => AuthRepo(
        cacheStorage: instance(),
        remoteDataSource: instance(),
        networkInfo: instance()));
    instance.registerLazySingleton<HomeCustomerRepo>(() => HomeCustomerRepo(
        remoteDataSource: instance(), networkInfo: instance()));
  }
}
