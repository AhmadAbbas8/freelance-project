import 'package:dartz/dartz.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/network/network_info.dart';
import 'package:grad_project/modules/home_customer/data/data_sources/action_customer_remote_data_source.dart';
import 'package:grad_project/modules/home_customer/data/model/project_model.dart';

import '../../../../core/error/exception.dart';

class ActionsCustomerRepo {
  final ActionsCustomerRemoteDataSource actionsCustomerRemoteDataSource;
  final NetworkInfo networkInfo;

  ActionsCustomerRepo({
    required this.actionsCustomerRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, Offers>> acceptOffer({
    required String projectId,
    required String offerId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        var res = await actionsCustomerRemoteDataSource.acceptOffer(
            projectId: projectId, offerId: offerId);
        return Right(res);
      } on ServerException catch (ex) {
        return Left(
          ServerFailure(model: ex.errorModel),
        );
      }
    } else {
      return const Left(OfflineFailure());
    }
  }
}
