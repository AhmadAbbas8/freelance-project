part of 'profiles_cubit.dart';

@immutable
sealed class ProfilesState {}

final class ProfilesInitial extends ProfilesState {}

final class GetProfilesDetailsLoading extends ProfilesState {}

final class GetProfilesDetailsError extends ProfilesState {
  final String msg;

  GetProfilesDetailsError({required this.msg});
}

final class GetProfilesDetailsSuccess extends ProfilesState {
  final ProfileDetails profile;

  GetProfilesDetailsSuccess({required this.profile});
}
