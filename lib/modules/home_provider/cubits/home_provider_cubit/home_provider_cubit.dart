import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grad_project/core/cache_helper/cache_storage.dart';
import 'package:grad_project/core/network/api/api_consumer.dart';
import 'package:grad_project/core/network/api/dio_consumer.dart';
import 'package:grad_project/core/utils/end_points.dart';
import 'package:grad_project/modules/home_customer/data/model/project_model.dart';
import 'package:meta/meta.dart';

import '../../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../../core/network/api/api_consumer.dart';
import '../../../../core/network/api/api_consumer.dart';
import '../../../../core/network/api/api_consumer.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../auth/data/user_model.dart';

part 'home_provider_state.dart';

class HomeProviderCubit extends Cubit<HomeProviderState> {
  HomeProviderCubit({required this.api}) : super(HomeProviderInitial());
  final ApiConsumer api;

  late UserModel user;

  getCachingUserModel() {
    var userJson = ServiceLocator.instance<CacheStorage>()
        .getData(key: SharedPrefsKeys.user);
    var userDecoded = jsonDecode(userJson);
    var userModel = UserModel.fromJson(userDecoded);
    user = userModel;
  }

  int currentIndexNav = 0;

  changeCurrentIndexNav(int index) {
    currentIndexNav = index;
    emit(ChangeCurrentIndex());
  }

  List<ProjectModel> projects = [];

  getProjects() async {
    projects.clear();
    emit(GetAllProjectProviderLoading());
    var res = await api.get(EndPoints.addNewProjects).then((value) {
      projects =
          (value.data as List).map((e) => ProjectModel.fromJson(e)).toList();
      emit(GetAllProjectProviderSuccess());
    }).catchError((er) {
      log(er.toString());
      emit(GetAllProjectProviderError());
    });
  }
}
