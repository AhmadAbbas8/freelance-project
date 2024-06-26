import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helpers/custom_progress_indicator.dart';
import 'package:grad_project/core/helpers/extensions/navigation_extensions.dart';
import 'package:grad_project/core/helpers/snackbars/snackbars.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/core/utils/assets_manager.dart';
import 'package:grad_project/core/utils/icon_broken.dart';
import 'package:grad_project/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:grad_project/modules/auth/auth_cubit/auth_logic.dart';
import 'package:grad_project/modules/auth/screens/resgister_screen.dart';
import 'package:grad_project/modules/auth/validator.dart';

import '../widgets/custom_text_form_field_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceLocator.instance<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showCustomProgressIndicator(context);
          }
          if (state is LoginError) {
            context.pop();
            ServiceLocator.instance<SnackBars>().error(
              context: context,
              message: state.msg,
            );
          }
          if (state is LoginSuccess) {
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: cubit.formKey,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Image.asset(
                          AssetsManager.loginImage,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.bodyLarge!,
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                'Welcome Back !',
                              ),
                            ],
                            repeatForever: false,
                            isRepeatingAnimation: true,
                            totalRepeatCount: 4,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      SliverList.list(
                        children: [
                          FadeInLeft(
                            child: CustomTextFormFieldLogin(
                              hintText: 'Email',
                              prefixIcon: IconBroken.User,
                              controller: cubit.emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: AppValidator.emailValidator,
                            ),
                          ),
                          SizedBox(height: 10),
                          FadeInRight(
                            child: CustomTextFormFieldLogin(
                              hintText: 'Password',
                              controller: cubit.passwordController,
                              prefixIcon: IconBroken.Lock,
                              obscureText: cubit.obscurePassword,
                              suffixIcon: IconButton(
                                onPressed: () => cubit.toggleObscurePassword(),
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
                        ],
                      ),
                      const SliverPadding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                      ),
                      SliverToBoxAdapter(
                        child: CupertinoButton(
                          onPressed: () async =>
                              cubit.formKey.currentState!.validate()
                                  ? await cubit.login()
                                  : null,
                          child: Text('Login'),
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SliverPadding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      SliverToBoxAdapter(
                        child: TextButton(
                          onPressed: () => context.push(
                            const RegisterScreen(),
                          ),
                          child: const Text('Don\'t have an account? Register'),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(bottom: 10),
                      ),
                    ],
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
