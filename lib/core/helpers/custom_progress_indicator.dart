import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> showCustomProgressIndicator(BuildContext context) async {
  return await showAdaptiveDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const AlertDialog.adaptive(
        backgroundColor: Colors.transparent,
        content: SpinKitDualRing(
          color: Colors.red,
        ),
      );
    },
  );
}
