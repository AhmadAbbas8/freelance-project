import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grad_project/core/helpers/custom_progress_indicator.dart';
import 'package:grad_project/core/helpers/extensions/navigation_extensions.dart';
import 'package:grad_project/core/helpers/snackbars/snackbars.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/core/utils/app_strings.dart';
import 'package:grad_project/modules/home_customer/logic/profiles_cubit/profiles_cubit.dart';
import 'package:grad_project/modules/profile/screen/profile_screen.dart';

import '../data/model/categories_model.dart';

class ProvidersScreen extends StatelessWidget {
  const ProvidersScreen({
    super.key,
    required this.title,
    required this.providers,
  });

  final String title;
  final List<Providers> providers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfilesCubit(
        api: ServiceLocator.instance(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
        ),
        body: BlocConsumer<ProfilesCubit, ProfilesState>(
          listener: (context, state) {
            if (state is GetProfilesDetailsLoading) {
              showCustomProgressIndicator(context);
            }
            if (state is GetProfilesDetailsError) {
              context.pop();
              ServiceLocator.instance<SnackBars>().error(
                context: context,
                message: state.msg,
              );
            }
            if (state is GetProfilesDetailsSuccess) {
              context.pop();
              context.push(ProfileScreen(profileDetails: state.profile));
            }
          },
          builder: (context, state) {
            return Visibility(
              visible: providers.isNotEmpty,
              replacement: Center(
                child: Text('There is No any Providers for $title'),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemBuilder: (context, index) =>
                        AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 1000),
                      child: FlipAnimation(
                        child: FadeInAnimation(
                          child: InkWell(
                            onTap: () => context
                                .read<ProfilesCubit>()
                                .getProviderProfile(
                                  providers[index].id.toString(),
                                ),
                            child: ListTile(
                              title: Text(
                                '${providers[index].firstName} ${providers[index].lastName}',
                              ),
                              subtitle: Text(
                                title,
                              ),
                              leading: const CircleAvatar(
                                backgroundImage:
                                    NetworkImage(AppStrings.defImageMale),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: providers.length,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

