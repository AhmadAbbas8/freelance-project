import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helpers/custom_progress_indicator.dart';
import 'package:grad_project/core/helpers/snackbars/snackbars.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/core/utils/icon_broken.dart';
import 'package:grad_project/modules/auth/validator.dart';
import 'package:grad_project/modules/auth/widgets/custom_text_form_field_login.dart';
import 'package:grad_project/modules/contact_us/cubit/contact_us_cubit.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactUsCubit(api: ServiceLocator.instance()),
      child: BlocConsumer<ContactUsCubit, ContactUsState>(
        listener: (context, state) {
          if (state is SaveContactUsLoading) {
            showCustomProgressIndicator(context);
          }
          if (state is SaveContactUsError) {
            Navigator.pop(context);
            ServiceLocator.instance<SnackBars>()
                .error(context: context, message: state.msg);
          }
          if (state is SaveContactUsSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            // Navigator.pop(context);
            ServiceLocator.instance<SnackBars>()
                .success(context: context, message: state.msg);
          }
        },
        builder: (context, state) {
          var cubit = context.read<ContactUsCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Contact Us',
              ),
            ),
            body: Form(
              key: cubit.formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomScrollView(
                  slivers: [
                    SliverList.list(
                      children: [
                        CustomTextFormFieldLogin(
                          hintText: 'Name',
                          controller: cubit.nameController,
                          prefixIcon: IconBroken.User,
                          validator: AppValidator.generalValidator,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormFieldLogin(
                          hintText: 'Email',
                          controller: cubit.emailController,
                          prefixIcon: IconBroken.User,
                          validator: AppValidator.emailValidator,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormFieldLogin(
                          hintText: 'Other info',
                          controller: cubit.additionalInfoController,
                          prefixIcon: IconBroken.Info_Circle,
                          validator: AppValidator.generalValidator,
                        ),
                        SizedBox(height: 10),
                        CustomTextFormFieldLogin(
                          hintText: 'Message',
                          maxLines: 3,
                          controller: cubit.memoController,
                          prefixIcon: IconBroken.Message,
                          validator: AppValidator.generalValidator,
                        ),
                      ],
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                    ),
                    SliverToBoxAdapter(
                      child: CupertinoButton(
                        onPressed: () async =>
                            cubit.formKey.currentState!.validate()
                                ? await cubit.saveContactUs()
                                : null,
                        child: Text('Login'),
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
