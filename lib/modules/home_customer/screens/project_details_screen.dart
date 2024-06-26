import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helpers/custom_progress_indicator.dart';
import 'package:grad_project/core/helpers/extensions/navigation_extensions.dart';
import 'package:grad_project/core/helpers/snackbars/snackbars.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/core/utils/app_strings.dart';
import 'package:grad_project/modules/auth/widgets/custom_text_form_field_login.dart';
import 'package:grad_project/modules/home_customer/data/model/project_model.dart';
import 'package:grad_project/modules/home_customer/logic/actions_cubit/actions_customer_cubit.dart';
import 'package:grad_project/modules/home_customer/widgets/custom_project_card_widget.dart';

import '../../../core/cache_helper/cache_storage.dart';
import '../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../core/utils/icon_broken.dart';
import '../../auth/data/user_model.dart';
import '../widgets/offer_item_widget.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({
    super.key,
    required this.project,
  });

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    var userJson = ServiceLocator.instance<CacheStorage>()
        .getData(key: SharedPrefsKeys.user);
    var userDecoded = json.decode(userJson);
    var user = UserModel.fromJson(userDecoded);
    return BlocProvider(
      create: (_) => ServiceLocator.instance<ActionsCustomerCubit>(),
      child: BlocConsumer<ActionsCustomerCubit, ActionsCustomerState>(
        listener: (context, state) {
          if (state is AcceptOfferLoading) {
            showCustomProgressIndicator(context);
          }
          if (state is AcceptOfferError) {
            context.pop();
            ServiceLocator.instance<SnackBars>()
                .error(context: context, message: state.msg);
          }
          if (state is AcceptOfferSuccess) {
            context.pop();
            ServiceLocator.instance<SnackBars>().success(
              context: context,
              message: AppStrings.createdSuccessfully,
            );
          }
          if (state is AddNewOfferLoading) {
            showCustomProgressIndicator(context);
          }
          if (state is AddNewOfferError) {
            context.pop();
            ServiceLocator.instance<SnackBars>()
                .error(context: context, message: state.msg);
          }
          if (state is AddNewOfferSuccess) {
            context.pop();
            project.offers!.add(state.offer);
            ServiceLocator.instance<SnackBars>().success(
              context: context,
              message: AppStrings.createdSuccessfully,
            );
          }
        },
        builder: (context, state) {
          var cubit = context.read<ActionsCustomerCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text('Project Details'),
            ),
            body: Column(
              children: [
                CustomProjectCardWidget(
                  project: project,
                  isDetailsAppear: false,
                ),
                Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    itemBuilder: (context, index) => OffersItemWidget(
                      offers: project.offers![index],
                      onAccept: () => cubit.acceptOffer(
                        projectId: project.id.toString(),
                        offerId: project.offers![index].id.toString(),
                      ),
                    ),
                    itemCount: project.offers?.length,
                  ),
                ),
                if (user.role == 'Provider')
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 10,
                    ),
                    child: CustomTextFormFieldLogin(
                      hintText: 'Write Your Offer',
                      controller: cubit.messageController,
                      suffixIcon: state is AddNewOfferLoading
                          ? CircularProgressIndicator()
                          : IconButton(
                              onPressed: () =>
                                  cubit.addNewOffer(project.id.toString()),
                              icon: Icon(
                                IconBroken.Send,
                              ),
                            ),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
