import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:grad_project/modules/auth/data/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial());
  final AuthRepo authRepo;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool obscurePassword = false;

  Future<void> login() async {
    emit(LoginLoading());
    var res = await authRepo.login(
      email: emailController.text,
      password: passwordController.text,
    );
    res.fold(
      (failure) => emit(LoginError(msg: failure.model.message ?? '')),
      (user) => emit(
          LoginSuccess(msg: 'Login Success , Welcome ${user.firstName} 😊 ')),
    );
  }

  toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    emit(ObscurePasswordChanged());
  }
}
