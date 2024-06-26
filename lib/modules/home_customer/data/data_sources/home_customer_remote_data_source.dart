import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:grad_project/core/error/default_response.dart';
import 'package:grad_project/core/error/exception.dart';
import 'package:grad_project/core/network/api/api_consumer.dart';
import 'package:grad_project/core/utils/app_strings.dart';
import 'package:grad_project/core/utils/end_points.dart';
import 'package:grad_project/modules/home_customer/data/model/categories_model.dart';
import 'package:grad_project/modules/home_customer/data/model/project_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/cache_helper/cache_storage.dart';
import '../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../core/service_locator/service_locator.dart';

class HomeCustomerRemoteDataSource {
  final ApiConsumer apiConsumer;

  HomeCustomerRemoteDataSource({
    required this.apiConsumer,
  });

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

  Future<List<ProjectModel>> getCurrentProject() async {
    List<ProjectModel> projects = [];
    try {
      var res = await apiConsumer.get(EndPoints.projectsCustomer);
      if (res.statusCode == 200) {
        projects = (res.data['value'] as List)
            .map((project) => ProjectModel.fromJson(project))
            .toList();
        return projects;
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

  Future<ProjectModel> addNewProject(dynamic data) async {
    try {
      var headers = {
        'Authorization':
            'Bearer ${ServiceLocator.instance<CacheStorage>().getData(key: SharedPrefsKeys.token)}'
      };
      var data2 = FormData.fromMap({
        'Image': await MultipartFile.fromFile((data['files'] as XFile).path,
            filename: (data['files'] as XFile).name.split('/').last),
        'Title': data['Title'],
        'Description': data['Description']
      });

      var dio = Dio();
      var response = await dio.request(
        'http://graduation-project.runasp.net/api/projects',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data2,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ProjectModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorModel: const DefaultResponse(message: AppStrings.serverError),
        );
      }
    } catch (ex) {
      log(ex.toString());
      if (ex is DioException) {
        if (ex.response?.statusCode == 400) {
          throw ServerException(
              errorModel: const DefaultResponse(
                  message:
                      'Description and title must be greater than 3 characters'));
        }
      }
      // print('------------------------${ex.toString()}');
      throw ServerException(
        errorModel: DefaultResponse(message: ex.toString()),
      );
    }
  }
}
