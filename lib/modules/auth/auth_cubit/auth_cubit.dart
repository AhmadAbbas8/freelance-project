import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:grad_project/core/helpers/extensions/date_format_extensions.dart';
import 'package:grad_project/modules/auth/data/auth_repo.dart';
import 'package:intl/intl.dart';

import '../../../core/ui_helper/custom_date_picker.dart';

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
  String? userType;

  final fieldController = TextEditingController();
  final addressController = TextEditingController();
  final governorateController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final experienceYearsController = TextEditingController();
  final birthDateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  Future<void> login() async {
    emit(LoginLoading());
    var res = await authRepo.login(
      email: emailController.text,
      password: passwordController.text,
    );
    res.fold(
      (failure) => emit(LoginError(msg: failure.model.message ?? '')),
      (user) => emit(LoginSuccess(
          msg: 'Login Success , Welcome ${user.firstName} 😊 ',
          role: user.role ?? '')),
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
        "birthDate": birthDateController.text,
        "isProvider":
            userType?.toUpperCase() == 'Provider'.toUpperCase() ? true : false,
        "isCustomer": userType?.toUpperCase() == 'Customer'.toUpperCase() ||
                userType == null
            ? true
            : false,
        "Field": fieldController.text,
        "Address": addressController.text,
        "Governorate": governorateController.text,
        "PhoneNumber": phoneNumberController.text,
        "experienceYears": int.tryParse(experienceYearsController.text) ?? 0,
      },
    );
    res.fold(
      (failure) => emit(SignUpError(msg: failure.model.message ?? '')),
      (user) => emit(SignUpSuccess(
          msg: 'Account Created Successfully , Welcome ${user.firstName} 😊 ',
          role: user.role ?? '')),
    );
  }

  toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    emit(ObscurePasswordChanged());
  }

  Future<void> onTapBirthDate(BuildContext context) async {
    var date = await buildCustomShowDatePicker(
      context,
      initialDate: birthDateController.text.isEmpty
          ? DateTime.now()
          : DateFormat().formatFromYyyymmdd(birthDateController.text),
    );
    try {
      birthDateController.text = DateFormat().formatToYyyymmdd(date!);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    fNameController.dispose();
    sNameController.dispose();
    // userTypeController.dispose();
    fieldController.dispose();
    addressController.dispose();
    governorateController.dispose();
    phoneNumberController.dispose();
    experienceYearsController.dispose();
    birthDateController.dispose();
    return super.close();
  }
}
