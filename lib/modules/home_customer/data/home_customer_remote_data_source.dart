import 'package:flutter/foundation.dart';
import 'package:grad_project/core/error/default_response.dart';
import 'package:grad_project/core/error/exception.dart';
import 'package:grad_project/core/network/api/api_consumer.dart';
import 'package:grad_project/core/utils/app_strings.dart';
import 'package:grad_project/core/utils/end_points.dart';
import 'package:grad_project/modules/home_customer/data/categories_model.dart';

class HomeCustomerRemoteDataSource {
  final ApiConsumer apiConsumer;

  HomeCustomerRemoteDataSource({required this.apiConsumer});

  Future<List<CategoriesModel>> getCategories() async {
    List<CategoriesModel> categories = [];
    try {
      var res = await apiConsumer.get(EndPoints.category);
      if (res.statusCode == 200) {
        categories = (res.data as List)
            .map((category) => CategoriesModel.fromJson(category))
            .toList();
        return categories;
      } else {
        throw ServerException(
          errorModel: const DefaultResponse(message: AppStrings.serverError),
        );
      }
    } catch (ex) {
      // print('------------------------${ex.toString()}');
      throw ServerException(
        errorModel: DefaultResponse(message: ex.toString()),
      );
    }
  }
}
