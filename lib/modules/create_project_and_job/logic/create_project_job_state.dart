part of 'create_project_job_cubit.dart';

@immutable
sealed class CreateProjectJobState {}

final class CreateProjectJobInitial extends CreateProjectJobState {}

final class UpdateJobLoading extends CreateProjectJobState {}

final class UpdateJobError extends CreateProjectJobState {
  final String msg;

  UpdateJobError({required this.msg});
}

final class UpdateJobSuccess extends CreateProjectJobState {
  final String msg;

  UpdateJobSuccess({required this.msg});
}

final class AddNewProjectLoading extends CreateProjectJobState {}

final class AddNewProjectError extends CreateProjectJobState {
  final String msg;

  AddNewProjectError({required this.msg});
}

final class AddNewProjectSuccess extends CreateProjectJobState {}

final class PickedImageSuccess extends CreateProjectJobState {
  final XFile? image;

  PickedImageSuccess({this.image});
}
