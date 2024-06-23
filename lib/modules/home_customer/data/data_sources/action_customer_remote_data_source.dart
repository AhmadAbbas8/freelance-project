import 'package:grad_project/core/network/api/api_consumer.dart';
import 'package:grad_project/modules/home_customer/data/model/project_model.dart';

import '../../../../core/error/default_response.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/end_points.dart';

class ActionsCustomerRemoteDataSource {
  final ApiConsumer apiConsumer;

  ActionsCustomerRemoteDataSource({required this.apiConsumer});

  Future<Offers> acceptOffer({
    required String projectId,
    required String offerId,
  }) async {
    try {
      var res = await apiConsumer.put(
          '${EndPoints.addNewProjects}/$projectId/Offres/$offerId/toggle-to-accepted');
      print('-----------------------------${res.data}');
      if (res.statusCode == 201 || res.statusCode == 200) {
        return Offers.fromJson({});
      } else {
        throw ServerException(
          errorModel: const DefaultResponse(message: AppStrings.errorTryAgain),
        );
      }
    } catch (ex) {
      print('--------------------${ex.toString()}');
      throw ServerException(
        errorModel: const DefaultResponse(message: AppStrings.errorTryAgain),
      );
    }
  }
}
