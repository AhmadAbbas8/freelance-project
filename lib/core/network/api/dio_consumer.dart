import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_consumer.dart';
import 'api_interceptors.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.interceptors.addAll([
      ApiInterceptor(),
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (object) => log(object.toString(), name: 'DioLogger'),
      )
    ]);
  }

  @override
  Future<Response?> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      var response = await dio.delete(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      var response = await dio.put(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return response;
    } on DioException catch (e) {
      log('---------------------on exeption');
      // rethrow;
      rethrow;
    }
  }

  @override
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      var response = await dio.patch(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      var response = await dio.post(path,
          data: isFromData ?FormData.fromMap(data): data,
          queryParameters: queryParameters,
          options: Options(
              contentType: isFromData
                  ? Headers.multipartFormDataContentType
                  : Headers.jsonContentType)
          );
      return response;
    } on DioException catch (e) {
      print(e.error.toString());
      rethrow;
    }
  }
}

// Exception handleDioExceptions(DioException e) {
//   log(e.response?.data.toString()??'',name: 'handleDioExceptions');
//   DefaultResponse defaultErrorModel = const DefaultResponse(
//     message: 'Error in Our Server , try again Later',
//   );
//   switch (e.type) {
//     case DioExceptionType.connectionTimeout:
//     case DioExceptionType.sendTimeout:
//     case DioExceptionType.receiveTimeout:
//     case DioExceptionType.badCertificate:
//     case DioExceptionType.cancel:
//     case DioExceptionType.connectionError:
//     case DioExceptionType.unknown:
//       return ServerException(errorModel: defaultErrorModel);
//     case DioExceptionType.badResponse:
//       switch (e.response?.statusCode) {
//         case 400: // Bad request
//           return e;
//
//         case 401: //unauthorized
//         case 402:
//         case 403:
//         case 404: //not found
//         case 405:
//         case 406:
//         case 407:
//         case 408:
//           return e;
//         case 409: //cofficient
//           return e;
//         case 422: //  Unprocessable Entity
//           return e;
//         case 504: // Server exception
//           return e;
//       }
//   }
//   return ServerException(errorModel: defaultErrorModel);
// }
