import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helpers/extensions/navigation_extensions.dart';
import 'package:grad_project/core/network/api/api_consumer.dart';
import 'package:grad_project/core/network/api/dio_consumer.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/core/utils/app_strings.dart';
import 'package:grad_project/core/widgets/custom_app_drawer.dart';
import 'package:grad_project/core/widgets/loading_widget.dart';
import 'package:grad_project/modules/create_project_and_job/screens/create_new_project_job_screen.dart';
import 'package:grad_project/modules/home_customer/logic/profiles_cubit/profiles_cubit.dart';
import 'package:grad_project/modules/home_provider/cubits/home_provider_cubit/home_provider_cubit.dart';
import 'package:grad_project/modules/home_provider/screens/jobs_provider_layout.dart';

import '../../../core/utils/icon_broken.dart';
import '../../home_customer/widgets/custom_project_card_widget.dart';

class HomeProviderScreen extends StatelessWidget {
  const HomeProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              HomeProviderCubit(api: ServiceLocator.instance<ApiConsumer>())
                ..getCachingUserModel()
                ..getProjects(),
        ),
        BlocProvider(
          create: (_) => ProfilesCubit(api: ServiceLocator.instance())
            ..getProviderItSelf(),
        ),
      ],
      child: BlocConsumer<HomeProviderCubit, HomeProviderState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = context.read<HomeProviderCubit>();
          return Scaffold(
            drawer: BlocBuilder<ProfilesCubit, ProfilesState>(
              builder: (context, state) {
                return CustomAppDrawer(
                  name: '${cubit.user.firstName} ${cubit.user.lastName}',
                  email: cubit.user.email ?? '',
                  profileImage: AppStrings.defImageMale,
                  profile: context.read<ProfilesCubit>().profile,
                );
              },
            ),
            appBar: AppBar(
              title: const Text('Home'),
            ),
            body: IndexedStack(
              index: cubit.currentIndexNav,
              children: [
                Visibility(
                  visible: state is! GetAllProjectProviderLoading,
                  replacement: LoadingWidget(),
                  child: Visibility(
                    replacement: Center(
                      child: Text('There is no any projects now'),
                    ),
                    visible: cubit.projects.isNotEmpty,
                    child: Center(
                      child: ListView.builder(
                        itemCount: cubit.projects.length,
                        itemBuilder: (_, index) => CustomProjectCardWidget(
                          project: cubit.projects[index],
                        ),
                      ),
                    ),
                  ),
                ),
                JobsProviderLayout(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndexNav,
              onTap: (index) => cubit.changeCurrentIndexNav(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Work),
                  tooltip: 'Projects',
                  label: 'Projects',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Work),
                  tooltip: 'Jobs',
                  label: 'Jobs',
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.push(
                CreateNewProjectScreen(isCreateProject: false),
              ),
              child: Icon(IconBroken.Plus),
            ),
          );
        },
      ),
    );
  }
}
