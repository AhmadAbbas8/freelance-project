import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:grad_project/core/cache_helper/cache_storage.dart';
import 'package:grad_project/core/cache_helper/shared_prefs_keys.dart';
import 'package:grad_project/core/error/exception.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/modules/auth/data/auth_remote_data_source.dart';
import 'package:grad_project/modules/auth/data/user_model.dart';

import '../../../core/network/network_info.dart';

class AuthRepo {
  final CacheStorage cacheStorage;
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepo({
    required this.cacheStorage,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        var user =
            await remoteDataSource.login(email: email, password: password);
        await cacheStorage.setData(
          key: SharedPrefsKeys.token,
          value: user.token ?? '',
        );
        await cacheStorage.setData(
          key: SharedPrefsKeys.user,
          value: json.encode(
            user.toJson(),
          ),
        );
        return Right(user);
      } on ServerException catch (e) {
        return Left(ServerFailure(model: e.errorModel));
      }
    } else {
      return const Left(OfflineFailure());
    }
  }

  Future<Either<Failure, UserModel>> signUp({
    required Map<String, dynamic> data,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        var user = await remoteDataSource.signUp(data: data);
        await cacheStorage.setData(
          key: SharedPrefsKeys.token,
          value: user.token ?? '',
        );
        await cacheStorage.setData(
          key: SharedPrefsKeys.user,
          value: json.encode(
            user.toJson(),
          ),
        );
        return Right(user);
      } on ServerException catch (e) {
        return Left(ServerFailure(model: e.errorModel));
      }
    } else {
      return const Left(OfflineFailure());
    }
  }
}
