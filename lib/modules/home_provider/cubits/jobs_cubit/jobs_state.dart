part of 'jobs_cubit.dart';

@immutable
sealed class JobsState {}

final class JobsInitial extends JobsState {}

final class GetAllJobsLoading extends JobsState {}

final class DeleteJobLoading extends JobsState {}

final class DeleteJobError extends JobsState {
  final String msg;

  DeleteJobError({required this.msg});
}

final class DeleteJobSuccess extends JobsState {
  final String msg;

  DeleteJobSuccess({required this.msg});
}

final class GetAllJobsError extends JobsState {
  final String msg;

  GetAllJobsError({required this.msg});
}

final class GetAllJobsSuccess extends JobsState {

}
