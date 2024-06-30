import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:grad_project/core/network/api/api_consumer.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit({
    required this.api,
  }) : super(ContactUsInitial());
  final ApiConsumer api;
  final formKey= GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final memoController = TextEditingController();
  final additionalInfoController = TextEditingController();

  saveContactUs() async {
    emit(SaveContactUsLoading());
    api
        .post('api/ContactUs', data: {
          "name": nameController.text,
          "email": emailController.text,
          "memo": memoController.text,
          "additionalInfo": additionalInfoController.text
        })
        .then((value) => emit(SaveContactUsSuccess(msg: 'Send Successfully')))
        .catchError((onError) =>
            emit(SaveContactUsError(msg: 'Error While Sending feedback')));
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    memoController.dispose();
    additionalInfoController.dispose();
    return super.close();
  }
}
