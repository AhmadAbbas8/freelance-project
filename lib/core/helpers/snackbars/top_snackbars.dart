import 'package:flutter/material.dart';
import 'package:grad_project/core/helpers/snackbars/snackbars.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


// TODO: Implement the snackbars in the UI
class TopSnackBars implements SnackBars {
  @override
  void success({required BuildContext context, required String message}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        boxShadow: const [],
        backgroundColor: Colors.green,
        message: message,
      ),
    );
  }

  @override
  void error({required BuildContext context, required String message}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        boxShadow: const [],
        backgroundColor: Colors.red,
        message: message,
      ),
    );
  }

  @override
  void info({required BuildContext context, required String message}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        boxShadow: const [],
        backgroundColor: Colors.orange,
        message: message,
      ),
    );
  }
}
