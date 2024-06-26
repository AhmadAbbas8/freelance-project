import 'package:flutter/cupertino.dart';
import 'package:grad_project/core/helpers/extensions/navigation_extensions.dart';
import 'package:grad_project/modules/home_customer/screens/home_customer_screen.dart';
import 'package:grad_project/modules/home_provider/screens/home_provider_screen.dart';

class AuthLogic {
  static checkUserRole(BuildContext context, String role) {
    switch (role.toUpperCase()) {
      case 'CUSTOMER':
        context.pushAndRemoveUntil(
          const HomeCustomerScreen(),
          (route) => false,
        );
        break;
      case 'PROVIDER':
        context.pushAndRemoveUntil(
          const HomeProviderScreen(),
          (route) => false,
        );
        break;
    }
  }
}
