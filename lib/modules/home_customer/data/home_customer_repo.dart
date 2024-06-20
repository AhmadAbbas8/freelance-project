import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/exception.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/network/network_info.dart';
import 'package:grad_project/modules/home_customer/data/home_customer_remote_data_source.dart';

import 'categories_model.dart';

class HomeCustomerRepo {
  final HomeCustomerRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeCustomerRepo({required this.remoteDataSource, required this.networkInfo});

  Future<Either<Failure, List<CategoriesModel>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        var res = await remoteDataSource.getCategories();
        return Right(res);
      } on ServerException catch (ex) {
        print('-----------------------server--------------');
        return Left(
          ServerFailure(model: ex.errorModel),
        );
      }
    } else {
      return const Left(OfflineFailure());
    }
  }
}
