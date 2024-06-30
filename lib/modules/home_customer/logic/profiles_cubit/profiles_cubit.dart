import 'package:bloc/bloc.dart';
import 'package:grad_project/core/network/api/api_consumer.dart';
import 'package:grad_project/core/utils/end_points.dart';
import 'package:grad_project/modules/home_customer/data/model/profile_details.dart';
import 'package:meta/meta.dart';

part 'profiles_state.dart';

class ProfilesCubit extends Cubit<ProfilesState> {
  ProfilesCubit({required this.api}) : super(ProfilesInitial());

  final ApiConsumer api;

  getProviderProfile(String providerId) {
    emit(GetProfilesDetailsLoading());
    api.get(EndPoints.getProviderProfile, queryParameters: {
      'providerId': providerId,
    }).then((value) {
      emit(GetProfilesDetailsSuccess(
          profile: ProfileDetails.fromJson(value.data)));
    }).catchError((onError) {
      emit(GetProfilesDetailsError(msg: 'Error While Get Provider '));
    });
  }

  ProfileDetails? profile;
  getProviderItSelf() {
    emit(GetProfilesDetailsLoading());
    api.get(EndPoints.getProviderProfileItSelf).then((value) {
      profile = ProfileDetails.fromJson(value.data);
      emit(GetProfilesDetailsSuccess(
          profile: ProfileDetails.fromJson(value.data)));
    }).catchError((onError) {
      emit(GetProfilesDetailsError(msg: 'Error While Get Provider '));
    });
  }
}
