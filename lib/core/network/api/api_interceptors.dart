import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers.addAll({
    //   'serverName': 'SQL9001.site4now.net',
    //   'DbName': 'db_aa30ae_zarqa',
    //   'username': 'db_aa30ae_zarqa_admin',
    //   'password': 'sql@1234',
    // });
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
