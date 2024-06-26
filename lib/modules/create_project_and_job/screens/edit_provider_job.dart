import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helpers/custom_progress_indicator.dart';
import 'package:grad_project/core/helpers/extensions/navigation_extensions.dart';
import 'package:grad_project/core/helpers/snackbars/snackbars.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/core/utils/end_points.dart';
import 'package:grad_project/core/utils/icon_broken.dart';
import 'package:grad_project/modules/auth/widgets/custom_text_form_field_login.dart';
import 'package:grad_project/modules/create_project_and_job/logic/create_project_job_cubit.dart';
import 'package:grad_project/modules/home_customer/screens/home_customer_screen.dart';
import 'package:grad_project/modules/home_provider/models/job_model.dart';
import 'package:grad_project/modules/home_provider/screens/home_provider_screen.dart';

class UpdateProviderJobScreen extends StatelessWidget {
  const UpdateProviderJobScreen({
    super.key,
    required this.job,
  });

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceLocator.instance<CreateProjectJobCubit>()
        ..onOpenUpdateJob(job),
      child: BlocConsumer<CreateProjectJobCubit, CreateProjectJobState>(
        listener: (context, state) {
          if (state is UpdateJobLoading) {
            showCustomProgressIndicator(context);
          }
          if (state is UpdateJobSuccess) {
            context.pushAndRemoveUntil(
                const HomeProviderScreen(), (route) => false);
            ServiceLocator.instance<SnackBars>().success(
              context: context,
              message: state.msg,
            );
          }
          if (state is UpdateJobError) {
            context.pop();
            ServiceLocator.instance<SnackBars>()
                .error(context: context, message: state.msg);
          }
        },
        builder: (context, state) {
          var cubit = context.read<CreateProjectJobCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Update Job',
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    if (cubit.checkAllValuesForCreateProject(false)) {
                      // if (isCreateProject) {
                      //   cubit.addNewProject();
                      // } else {
                        await cubit.updateProviderJob(job.id??0);
                      // }
                    } else {
                      ServiceLocator.instance<SnackBars>().info(
                        context: context,
                        message: 'Please Complete Data ',
                      );
                    }
                  },
                  icon: const Icon(IconBroken.Upload),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomScrollView(
                slivers: [
                  const SliverPadding(padding: EdgeInsets.only(top: 10)),
                  SliverList.list(
                    children: [
                      CustomTextFormFieldLogin(
                        hintText: 'Write Title',
                        controller: cubit.titleController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormFieldLogin(
                        hintText: 'Write Description',
                        controller: cubit.descriptionController,
                        maxLines: 3,
                      ),
                      ...[
                        const SizedBox(height: 10),
                        CustomTextFormFieldLogin(
                          hintText: 'Start Date',
                          readOnly: true,
                          controller: cubit.startDateController,
                          onTap: () => cubit.onTapStartDate(context),
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormFieldLogin(
                          hintText: 'End Date',
                          readOnly: true,
                          controller: cubit.endDateController,
                          onTap: () => cubit.onTapEndDate(context),
                        ),
                      ]
                    ],
                  ),
                  const SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 20)),
                  SliverToBoxAdapter(
                    child: CupertinoButton(
                      onPressed: () async => await cubit.pickImage(),
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      child: const Text(
                        'Select Image',
                      ),
                    ),
                  ),
                  const SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 10)),
                  // if (cubit.image != null)
                  SliverFillRemaining(
                    // fillOverscroll: true,
                    hasScrollBody: false,
                    child: cubit.image == null
                        ? Image.network(
                            '${EndPoints.BASE_URL}images/${job.imageName}')
                        : Image.file(
                            File(cubit.image!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
