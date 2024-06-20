import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grad_project/core/cache_helper/cache_storage.dart';
import 'package:grad_project/core/cache_helper/shared_prefs_keys.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Authorization':
          'Bearer ${ServiceLocator.instance<CacheStorage>().getData(key: SharedPrefsKeys.token)}'
    });
    log(json.encode(options.data), name: 'onRequest');
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log(json.encode(err.response?.data ?? ''), name: 'onError');
    super.onError(err, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // log('---------------------onResponse-------------------------------');

    super.onResponse(response, handler);
  }
}
