import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helpers/custom_progress_indicator.dart';
import 'package:grad_project/core/helpers/extensions/navigation_extensions.dart';
import 'package:grad_project/core/helpers/snackbars/snackbars.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/core/utils/icon_broken.dart';
import 'package:grad_project/modules/auth/widgets/custom_text_form_field_login.dart';
import 'package:grad_project/modules/home_customer/logic/home_customer_cubit.dart';
import 'package:grad_project/modules/home_customer/screens/home_customer_screen.dart';

class CreateNewProjectScreen extends StatelessWidget {
  const CreateNewProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceLocator.instance<HomeCustomerCubit>(),
      child: BlocConsumer<HomeCustomerCubit, HomeCustomerState>(
        listener: (context, state) {
          if (state is AddNewProjectLoading) {
            showCustomProgressIndicator(context);
          }
          if (state is AddNewProjectSuccess) {
            context.pushAndRemoveUntil(HomeCustomerScreen(), (route) => false);
            ServiceLocator.instance<SnackBars>().success(
              context: context,
              message: 'Added Successfully',
            );
          }
          if (state is AddNewProjectError) {
            context.pop();
            ServiceLocator.instance<SnackBars>()
                .error(context: context, message: state.msg);
          }
        },
        builder: (context, state) {
          var cubit = context.read<HomeCustomerCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'New Project',
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    if (cubit.checkAllValuesForCreateProject()) {
                      cubit.addNewProject();
                    } else {
                      ServiceLocator.instance<SnackBars>().info(
                        context: context,
                        message: 'Please Complete Data ',
                      );
                    }
                  },
                  icon: const Icon(IconBroken.Plus),
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
                      SizedBox(height: 10),
                      CustomTextFormFieldLogin(
                        hintText: 'Write Description',
                        controller: cubit.descriptionController,
                        maxLines: 3,
                      ),
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
                  if (cubit.image != null)
                    SliverFillRemaining(
                      // fillOverscroll: true,
                      hasScrollBody: false,
                      child: Image.file(
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
