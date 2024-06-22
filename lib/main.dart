import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/bloc_observer.dart';
import 'package:grad_project/core/helpers/app_theme.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/modules/home_customer/data/project_model.dart';
import 'package:grad_project/modules/home_customer/screens/home_customer_screen.dart';

import 'modules/auth/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await ServiceLocator.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: Locale('en'),
      home: const HomeCustomerScreen(),
    );
  }
}

