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
    //       'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjI0ZTI2ZTAwLTVkNDYtNDUwMi04NzMyLTlmYzc5OTQyN2FhMyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFsaVByb3ZpZGVyMUBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9naXZlbm5hbWUiOiJrYWFhYWEgdGFhYWEiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJQcm92aWRlciIsIkp0aSI6IjNmODdjOWU3LWViZTktNGQ1NC05MDBhLWNjOGI3MDcwYTdkZiIsImV4cCI6MTczNzI0ODkwNywiaXNzIjoiU3VydmV5QmFza2V0IiwiYXVkIjoiU3VydmV5QmFza2V0IFVzZXJzIn0.rJ8OFf_5Y7104lj6GCkQTpXVgLbOZKNnPGvWcYWhIZM'
    // });
    options.headers.addAll({
      'Authorization':
          'Bearer ${ServiceLocator.instance<CacheStorage>().getData(key: SharedPrefsKeys.token)}'
    });
    log(ServiceLocator.instance<CacheStorage>()
        .getData(key: SharedPrefsKeys.token)??'');
    // log(json.encode(options.data), name: 'onRequest');
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log(json.encode(err.response?.data ?? ''), name: 'onError');
    // log(json.encode(err.message ?? ''), name: 'onError');
    super.onError(err, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // log('---------------------onResponse-------------------------------');

    super.onResponse(response, handler);
  }

}
