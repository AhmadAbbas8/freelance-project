import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helpers/extensions/date_format_extensions.dart';
import 'package:grad_project/core/helpers/extensions/navigation_extensions.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/core/ui_helper/custom_date_picker.dart';
import 'package:grad_project/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:grad_project/modules/home_customer/screens/home_customer_screen.dart';
import 'package:intl/intl.dart';

import '../../../core/helpers/custom_progress_indicator.dart';
import '../../../core/helpers/snackbars/snackbars.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/icon_broken.dart';
import '../auth_cubit/auth_logic.dart';
import '../validator.dart';
import '../widgets/custom_text_form_field_login.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceLocator.instance<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignUpLoading) {
            showCustomProgressIndicator(context);
          }
          if (state is SignUpError) {
            context.pop();
            ServiceLocator.instance<SnackBars>().error(
              context: context,
              message: state.msg,
            );
          }
          if (state is SignUpSuccess) {
            context.pop();
            ServiceLocator.instance<SnackBars>().success(
              context: context,
              message: state.msg,
            );
            AuthLogic.checkUserRole(context, state.role);
          }
        },
        builder: (context, state) {
          var cubit = context.read<AuthCubit>();
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: cubit.formKey,
                  child: StatefulBuilder(
                    builder: (context, setState) => CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Image.asset(
                            AssetsManager.loginImage,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: DefaultTextStyle(
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 16),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TyperAnimatedText(
                                  'signUp Now to get your Service !',
                                ),
                              ],
                              repeatForever: false,
                              isRepeatingAnimation: true,
                              totalRepeatCount: 4,
                            ),
                          ),
                        ),
                        const SliverPadding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        SliverList.list(
                          children: [
                            FadeInLeft(
                              child: CustomTextFormFieldLogin(
                                hintText: 'First Name',
                                prefixIcon: IconBroken.User,
                                controller: cubit.fNameController,
                                keyboardType: TextInputType.text,
                                validator: AppValidator.generalValidator,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInRight(
                              child: CustomTextFormFieldLogin(
                                hintText: 'Second Name',
                                controller: cubit.sNameController,
                                prefixIcon: IconBroken.User,
                                keyboardType: TextInputType.text,
                                validator: AppValidator.generalValidator,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInLeft(
                              child: CustomTextFormFieldLogin(
                                hintText: 'Email',
                                controller: cubit.emailController,
                                prefixIcon: IconBroken.User,
                                keyboardType: TextInputType.emailAddress,
                                validator: AppValidator.emailValidator,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInRight(
                              child: CustomTextFormFieldLogin(
                                hintText: 'Password',
                                controller: cubit.passwordController,
                                prefixIcon: IconBroken.Lock,
                                obscureText: cubit.obscurePassword,
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      cubit.toggleObscurePassword(),
                                  icon: Icon(
                                    cubit.obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                validator: AppValidator.passwordValidator,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile.adaptive(
                                    value: 'Customer',
                                    title: Text(
                                      'Customer',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    groupValue: cubit.userType,
                                    onChanged: (value) {
                                      setState(() => cubit.userType = value!);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile.adaptive(
                                    value: 'Provider',
                                    title: Text(
                                      'Provider',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    groupValue: cubit.userType,
                                    onChanged: (value) {
                                      setState(() => cubit.userType = value!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            if (cubit.userType?.toUpperCase() ==
                                'Provider'.toUpperCase())
                              FadeInRight(
                                child: CustomTextFormFieldLogin(
                                  hintText: 'Field',
                                  controller: cubit.fieldController,
                                  prefixIcon: IconBroken.Document,
                                  keyboardType: TextInputType.text,
                                  validator: AppValidator.generalValidator,
                                ),
                              ),
                            const SizedBox(height: 10),
                            FadeInLeft(
                              child: CustomTextFormFieldLogin(
                                hintText: 'Address',
                                controller: cubit.addressController,
                                prefixIcon: IconBroken.Location,
                                keyboardType: TextInputType.text,
                                validator: AppValidator.generalValidator,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInRight(
                              child: CustomTextFormFieldLogin(
                                hintText: 'Governorate',
                                controller: cubit.governorateController,
                                prefixIcon: IconBroken.Location,
                                keyboardType: TextInputType.text,
                                validator: AppValidator.generalValidator,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInLeft(
                              child: CustomTextFormFieldLogin(
                                hintText: 'Phone Number',
                                controller: cubit.phoneNumberController,
                                prefixIcon: IconBroken.Call,
                                keyboardType: TextInputType.phone,
                                validator: AppValidator.generalValidator,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (cubit.userType?.toUpperCase() ==
                                'Provider'.toUpperCase())   FadeInRight(
                              child: CustomTextFormFieldLogin(
                                hintText: 'Experience Years',
                                controller: cubit.experienceYearsController,
                                prefixIcon: IconBroken.Work,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: AppValidator.generalValidator,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInLeft(
                              child: CustomTextFormFieldLogin(
                                hintText: 'Birth Date',
                                controller: cubit.birthDateController,
                                prefixIcon: IconBroken.Calendar,
                                keyboardType: TextInputType.number,
                                validator: AppValidator.generalValidator,
                                readOnly: true,
                                onTap: () async =>
                                    await cubit.onTapBirthDate(context),
                              ),
                            ),
                          ],
                        ),
                        const SliverPadding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                        ),
                        SliverToBoxAdapter(
                          child: CupertinoButton(
                            onPressed: () async =>
                                cubit.formKey.currentState!.validate()
                                    ? await cubit.signUp()
                                    : null,
                            child: const Text('SignUp'),
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SliverPadding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        SliverToBoxAdapter(
                          child: TextButton(
                            onPressed: () => context.pop(),
                            child: const Text('Already have an account? Login'),
                          ),
                        ),
                        const SliverPadding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                      ],
                    ),
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
