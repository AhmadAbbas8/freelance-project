import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/core/utils/colors_palette.dart';
import 'package:grad_project/core/utils/end_points.dart';
import 'package:grad_project/core/widgets/custom_app_drawer.dart';
import 'package:grad_project/core/widgets/loading_widget.dart';
import 'package:grad_project/modules/home_customer/logic/home_customer_cubit.dart';

import '../widgets/custom_home_customer_card.dart';

class HomeCustomerScreen extends StatelessWidget {
  const HomeCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceLocator.instance<HomeCustomerCubit>()
        ..getCachingUserModel()
        ..getCategories(),
      child: BlocConsumer<HomeCustomerCubit, HomeCustomerState>(
        listener: (context, state) {},
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
              title: const Text('Home'),
            ),
            body: Center(
              child: Visibility(
                visible: state is FetchCategoriesLoading,
                child: const LoadingWidget(),
                replacement: Visibility(
                  visible: cubit.categories.isEmpty,
                  replacement: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: cubit.categories.length,
                      itemBuilder: (_, index) =>
                          AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 1000),
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: CustomHomeCustomerCard(
                              title: cubit.categories[index].title ?? '',
                              providers:
                                  cubit.categories[index].providers ?? [],
                              description:
                                  cubit.categories[index].description ?? '',
                              imageUrl:
                                  '${EndPoints.BASE_URL}/images/${cubit.categories[index].imageName}',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  child: const Text('There is No any Category'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
