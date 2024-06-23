import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grad_project/core/cache_helper/cache_storage.dart';
import 'package:grad_project/core/cache_helper/shared_prefs_keys.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers.addAll({
    //   'Authorization':
    //       'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjM2M2UzMGMyLWMxNTMtNDcyZi05MTA4LTFlYjZhOGE1M2YwYiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFsaUN1c3RvbWVyMUBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9naXZlbm5hbWUiOiJrYWFhYWEgdGFhYWEiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJDdXN0b21lciIsIkp0aSI6IjU2NGVmNjBiLTkwMGMtNGE3OS05OThiLTQyYTgwY2NiNDYzMSIsImV4cCI6MTczNjk0MTMyOSwiaXNzIjoiU3VydmV5QmFza2V0IiwiYXVkIjoiU3VydmV5QmFza2V0IFVzZXJzIn0.wDV0FRa1pYOU_Pad8smdfy5hAUXrQMiBDSd9M-l9T6c'
    // });
    options.headers.addAll({
      'Authorization':
          'Bearer ${ServiceLocator.instance<CacheStorage>().getData(key: SharedPrefsKeys.token)}'
    });
    log(ServiceLocator.instance<CacheStorage>()
        .getData(key: SharedPrefsKeys.token)??'');
    log(json.encode(options.data), name: 'onRequest');
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log(json.encode(err.response?.data ?? ''), name: 'onError');
    log(json.encode(err.message ?? ''), name: 'onError');
    super.onError(err, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // log('---------------------onResponse-------------------------------');

    super.onResponse(response, handler);
  }
}
