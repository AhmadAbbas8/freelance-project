import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grad_project/core/network/api/api_consumer.dart';
import 'package:grad_project/core/utils/end_points.dart';
import 'package:grad_project/modules/home_provider/models/job_model.dart';
import 'package:meta/meta.dart';

part 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit({required ApiConsumer apiConsumer})
      : _api = apiConsumer,
        super(JobsInitial());
  final ApiConsumer _api;

  List<JobModel> jobs = [];

  deleteJob(int index)  {
    emit(DeleteJobLoading());
    _api.delete('${EndPoints.jobs}/${jobs[index].id}').then((_) {
      jobs.removeAt(index);
      emit(DeleteJobSuccess(msg: 'Job Deleted Successfully'));
    }).onError((e,onError) {
      log(onError.toString(),name: 'onerror cubit');
      emit(DeleteJobError(msg: 'Error occur while deleted job'));
    });
  }

  getAllJobs() async {
    jobs.clear();
    emit(GetAllJobsLoading());
    var res = await _api.get(EndPoints.jobs).then((value) {
      jobs = (value.data as List).map((e) => JobModel.fromJson(e)).toList();
      emit(GetAllJobsSuccess());
    }).catchError((e) {
      emit(GetAllJobsError(msg: 'Error While Fetch All Jobs'));
    });
  }
}
