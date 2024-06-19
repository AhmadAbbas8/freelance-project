import 'package:dio/dio.dart';
import 'package:grad_project/core/error/default_response.dart';
import 'package:grad_project/core/error/exception.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/network/api/api_consumer.dart';
import 'package:grad_project/core/utils/end_points.dart';
import 'package:grad_project/modules/auth/data/user_model.dart';

class AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthRemoteDataSource({required this.apiConsumer});

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      var res = await apiConsumer.post(
        EndPoints.auth,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (res.statusCode == 200) {

        return UserModel.fromJson(res.data);
      } else {
        throw ServerException(
            errorModel: DefaultResponse(message: 'Try Again Later'));
      }
    } catch (ex) {
      // if (ex.response?.statusCode == 400) {
      throw ServerException(
          errorModel: DefaultResponse(message: 'Invalid UserName or password'));
      // }
    }
  }

  Future<UserModel> signUp({
    required Map<String, dynamic> data,
  }) async {
    try {
      var res = await apiConsumer.post(
        EndPoints.register,
        data: data,
      );
      if (res.statusCode == 200) {
        return UserModel.fromJson(res.data);
      } else {
        throw ServerException(
            errorModel: const DefaultResponse(
                message: 'Email already exists try to login'));
      }
    } catch (ex) {
      if (ex is DioException) {
        if (ex.response?.statusCode == 400) {
          throw ServerException(
            errorModel: DefaultResponse(message: ex.response?.data ?? ''),
          );
        }
      }
      // if (ex.response?.statusCode == 400) {
      throw ServerException(
          errorModel: const DefaultResponse(
              message: 'Error in our server please try again later'));
      // }
    }
  }
}
