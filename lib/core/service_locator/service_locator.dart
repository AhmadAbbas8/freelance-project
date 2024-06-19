import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
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


    // * DataSources


    // * Repository

  }
}
