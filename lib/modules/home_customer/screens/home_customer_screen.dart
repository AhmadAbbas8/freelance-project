import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grad_project/core/helpers/custom_progress_indicator.dart';
import 'package:grad_project/core/helpers/extensions/navigation_extensions.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/core/utils/app_strings.dart';
import 'package:grad_project/core/utils/colors_palette.dart';
import 'package:grad_project/core/utils/end_points.dart';
import 'package:grad_project/core/utils/icon_broken.dart';
import 'package:grad_project/core/widgets/custom_app_drawer.dart';
import 'package:grad_project/core/widgets/loading_widget.dart';
import 'package:grad_project/modules/home_customer/data/model/project_model.dart';
import 'package:grad_project/modules/home_customer/logic/home_customer_cubit.dart';
import 'package:grad_project/modules/create_project_and_job/screens/create_new_project_job_screen.dart';

import '../../../core/helpers/snackbars/snackbars.dart';
import '../widgets/categories_widget_layout.dart';
import '../widgets/custom_home_customer_card.dart';
import '../widgets/custom_project_card_widget.dart';

class HomeCustomerScreen extends StatelessWidget {
  const HomeCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceLocator.instance<HomeCustomerCubit>()
        ..getCachingUserModel()
        ..getCategories()
        ..fetchProjectsCustomer(),
      child: BlocConsumer<HomeCustomerCubit, HomeCustomerState>(
        listener: (context, state) {
          if (state is MakeProjectAssignedOrDoneLoading) {
            showCustomProgressIndicator(context);
          }
          if (state is MakeProjectAssignedOrDoneError) {
            Navigator.pop(context);
            ServiceLocator.instance<SnackBars>()
                .error(context: context, message: state.msg);
          }
          if (state is MakeProjectAssignedOrDoneSuccess) {
            Navigator.pop(context);
            ServiceLocator.instance<SnackBars>()
                .success(context: context, message: state.msg);
          }
        },
        builder: (context, state) {
          var cubit = context.read<HomeCustomerCubit>();
          return Scaffold(
            drawer: CustomAppDrawer(
              name: '${cubit.user.firstName} ${cubit.user.lastName}',
              email: '${cubit.user.email}',
              profileImage:
                  'http://graduationprt24-001-site1.jtempurl.com/Profile/default/male.png',
            ),
            appBar: AppBar(
              title: Text(
                cubit.title[cubit.currentBottomNavIndex],
              ),
            ),
            body: IndexedStack(
              index: cubit.currentBottomNavIndex,
              children: [
                CategoriesWidgetLayout(cubit: cubit, state: state),
                Visibility(
                  visible: cubit.projects.isNotEmpty,
                  replacement: Text('There is no any projects now'),
                  child: Center(
                    child: ListView.builder(
                      itemCount: cubit.projects.length,
                      itemBuilder: (_, index) => CustomProjectCardWidget(
                        project: cubit.projects[index],
                        onPressedAssigned: () => cubit
                            .makeProjectAssigned(cubit.projects[index].id ?? 0),
                        onPressedDone: () => cubit
                            .makeProjectDone(cubit.projects[index].id ?? 0),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Visibility(
                    visible: cubit.projectsCompleted.isNotEmpty,
                    replacement: Text('There is no any Projects finished'),
                    child: ListView.builder(
                      itemCount: cubit.projectsCompleted.length,
                      itemBuilder: (_, index) => CustomProjectCardWidget(
                        project: cubit.projectsCompleted[index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.push(
                const CreateNewProjectScreen(isCreateProject: true),
              ),
              child: const Icon(IconBroken.Plus),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentBottomNavIndex,
              type: BottomNavigationBarType.fixed,
              onTap: cubit.changeBottomNavIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                  tooltip: 'Home',
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Work),
                  tooltip: 'Projects',
                  label: 'Projects',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Star),
                  tooltip: 'Finished',
                  label: 'Finished',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
