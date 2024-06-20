import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:grad_project/core/cache_helper/cache_storage.dart';
import 'package:grad_project/core/cache_helper/shared_prefs_keys.dart';
import 'package:grad_project/modules/home_customer/data/categories_model.dart';
import 'package:grad_project/modules/home_customer/data/home_customer_repo.dart';
import 'package:meta/meta.dart';

import '../../auth/data/user_model.dart';

part 'home_customer_state.dart';

class HomeCustomerCubit extends Cubit<HomeCustomerState> {
  HomeCustomerCubit({
    required this.cacheStorage,
    required this.homeCustomerRepo,
  }) : super(HomeCustomerInitial());
  final CacheStorage cacheStorage;
  final HomeCustomerRepo homeCustomerRepo;

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
}
