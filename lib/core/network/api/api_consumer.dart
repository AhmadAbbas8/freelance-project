import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<Response> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  });


  Future<Response> put(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        bool isFromData = false,
      });

  Future<Response> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  });

  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  });
}
