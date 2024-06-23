import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/network/api/api_consumer.dart';
import 'package:grad_project/core/network/api/dio_consumer.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/core/utils/app_strings.dart';
import 'package:grad_project/core/widgets/custom_app_drawer.dart';
import 'package:grad_project/modules/home_provider/cubits/home_provider_cubit/home_provider_cubit.dart';

import '../../../core/utils/icon_broken.dart';
import '../../home_customer/widgets/custom_project_card_widget.dart';

class HomeProviderScreen extends StatelessWidget {
  const HomeProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeProviderCubit(api: ServiceLocator.instance<ApiConsumer>())
            ..getCachingUserModel()
            ..getProjects(),
      child: BlocConsumer<HomeProviderCubit, HomeProviderState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = context.read<HomeProviderCubit>();
          return Scaffold(
            drawer: CustomAppDrawer(
              name: '${cubit.user.firstName} ${cubit.user.lastName}',
              email: cubit.user.email ?? '',
              profileImage: AppStrings.defImageMale,
            ),
            appBar: AppBar(
              title: const Text('Home'),
            ),
            body: Visibility(
              visible: cubit.projects.isNotEmpty,
              replacement: Center(
                child: Text('There is no any projects now'),
              ),
              child: Center(
                child: ListView.builder(
                  itemCount: cubit.projects.length,
                  itemBuilder: (_, index) => CustomProjectCardWidget(
                    project: cubit.projects[index],
                  ),
                ),
              ),
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
                  tooltip: 'Done',
                  label: 'Done',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
