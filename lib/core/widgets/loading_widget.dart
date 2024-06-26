import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grad_project/core/utils/colors_palette.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SpinKitFadingFour(
      color:ColorsPalette.primaryColorApp,
      size: 100,
    );
  }
}
