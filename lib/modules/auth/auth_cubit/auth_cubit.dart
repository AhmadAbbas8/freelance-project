import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:grad_project/modules/auth/data/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.authRepo,
  }) : super(AuthInitial());
  final AuthRepo authRepo;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fNameController = TextEditingController();
  final sNameController = TextEditingController();
  final userTypeController = TextEditingController();
  final fieldController = TextEditingController();
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

  Future<void> signUp() async {
    emit(SignUpLoading());
    var res = await authRepo.signUp(
      data: {
        "firstName": fNameController.text,
        "lastName": sNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "confirmPassword": passwordController.text,
        "userType": userTypeController.text,
        "field": fieldController.text,
      },
    );
    res.fold(
      (failure) => emit(SignUpError(msg: failure.model.message ?? '')),
      (user) => emit(SignUpSuccess(
          msg: 'Account Created Successfully , Welcome ${user.firstName} 😊 ')),
    );
  }

  toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    emit(ObscurePasswordChanged());
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    fNameController.dispose();
    sNameController.dispose();
    userTypeController.dispose();
    fieldController.dispose();
    return super.close();
  }
}
