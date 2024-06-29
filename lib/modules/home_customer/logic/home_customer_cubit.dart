import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http_parser/src/media_type.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:grad_project/core/cache_helper/cache_storage.dart';
import 'package:grad_project/core/cache_helper/shared_prefs_keys.dart';
import 'package:grad_project/core/network/api/api_consumer.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/modules/home_customer/data/repo/home_customer_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/end_points.dart';
import '../../auth/data/user_model.dart';
import '../data/model/categories_model.dart';
import '../data/model/project_model.dart';

part 'home_customer_state.dart';

class HomeCustomerCubit extends Cubit<HomeCustomerState> {
  HomeCustomerCubit({
    required this.cacheStorage,
    required this.homeCustomerRepo,
    required this.apiConsumer,
  }) : super(HomeCustomerInitial());
  final CacheStorage cacheStorage;
  final HomeCustomerRepo homeCustomerRepo;
  final ImagePicker picker = ImagePicker();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ApiConsumer apiConsumer;

  late UserModel user;

  getCachingUserModel() {
    var userJson = cacheStorage.getData(key: SharedPrefsKeys.user);
    var userDecoded = jsonDecode(userJson);
    var userModel = UserModel.fromJson(userDecoded);
    user = userModel;
  }

  List<CategoriesModel> categories = [];

  Future<void> getCategories() async {
    categories.clear();
    emit(FetchCategoriesLoading());
    var res = await homeCustomerRepo.getCategories();
    res.fold(
      (l) => emit(FetchCategoriesError(msg: l.model.message ?? '')),
      (r) {
        categories = r;
        emit(FetchCategoriesSuccess());
      },
    );
  }

  int currentBottomNavIndex = 0;
  var title = const ['Home', 'Projects', 'Finished'];

  void changeBottomNavIndex(int index) {
    currentBottomNavIndex = index;
    emit(ChangeBottomNavIndex());
  }

  List<ProjectModel> projects = [];
  List<ProjectModel> projectsCompleted = [];

  fetchProjectsCustomer() async {
    projects.clear();
    projectsCompleted.clear();
    emit(FetchCurrentProjectCustomerLoading());
    var res = await homeCustomerRepo.getCurrentProject();
    res.fold(
      (l) => emit(FetchCurrentProjectCustomerError(msg: l.model.message ?? '')),
      (r) {
        for (var element in r) {
          if (element.status?.toUpperCase() == 'Completed'.toUpperCase()) {
            projectsCompleted.add(element);
          } else {
            projects.add(element);
          }
        }
        // projects = r;
        FetchCurrentProjectCustomerSuccess(projects: r);
      },
    );
  }

  makeProjectAssigned(int projectId) {
    emit(MakeProjectAssignedOrDoneLoading());
    apiConsumer.put('api/projects/$projectId/toggle-to-assigned').then((value) {
      emit(MakeProjectAssignedOrDoneSuccess(msg: 'Toggle to Assigned Successfully'));
    }).catchError((onError) {
      emit(MakeProjectAssignedOrDoneError(
          msg: 'Error While Making project Assigned'));
    });
  }

  makeProjectDone(int projectId) {
    emit(MakeProjectAssignedOrDoneLoading());
    apiConsumer.put('api/projects/$projectId/toggle-to-completed').then((value) {
      emit(MakeProjectAssignedOrDoneSuccess(msg: 'Toggle to Completed Successfully'));
    }).catchError((onError) {
      emit(MakeProjectAssignedOrDoneError(
          msg: 'Error While Making project Completed'));
    });
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}
