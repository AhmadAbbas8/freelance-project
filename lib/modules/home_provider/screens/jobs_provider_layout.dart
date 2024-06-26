import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helpers/custom_progress_indicator.dart';
import 'package:grad_project/core/helpers/snackbars/snackbars.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/core/widgets/loading_widget.dart';
import 'package:grad_project/modules/home_provider/cubits/jobs_cubit/jobs_cubit.dart';
import 'package:grad_project/modules/home_provider/models/job_model.dart';

import '../../../core/utils/colors_palette.dart';
import '../../../core/utils/end_points.dart';
import '../widgets/custome_job_card_widget.dart';

class JobsProviderLayout extends StatelessWidget {
  const JobsProviderLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceLocator.instance<JobsCubit>()..getAllJobs(),
      child: BlocConsumer<JobsCubit, JobsState>(
        listener: (context, state) {
          if (state is DeleteJobLoading) {
            showCustomProgressIndicator(context);
          }

          if (state is DeleteJobError) {
            Navigator.pop(context);
            ServiceLocator.instance<SnackBars>().error(
              context: context,
              message: state.msg,
            );
          }

          if (state is DeleteJobSuccess) {
            Navigator.pop(context);
            ServiceLocator.instance<SnackBars>().success(
              context: context,
              message: state.msg,
            );
          }
        },
        builder: (context, state) {
          var cubit = context.read<JobsCubit>();
          return Scaffold(
            body: Center(
              child: Visibility(
                visible: state is! GetAllJobsLoading,
                replacement: LoadingWidget(),
                child: Visibility(
                  visible: cubit.jobs.isNotEmpty,
                  replacement: Text(
                    'There is no any jobs now ',
                  ),
                  child: ListView.builder(
                    itemBuilder: (context, index) => CustomJobsCardWidget(
                      job: cubit.jobs[index],
                      onPressedDelete: () => cubit.deleteJob(index),
                    ),
                    itemCount: cubit.jobs.length,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
