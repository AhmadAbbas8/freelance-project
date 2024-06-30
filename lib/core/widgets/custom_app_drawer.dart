import 'package:flutter/material.dart';
import 'package:grad_project/core/helpers/extensions/navigation_extensions.dart';
import 'package:grad_project/modules/auth/data/auth_remote_data_source.dart';
import 'package:grad_project/modules/auth/screens/login_screen.dart';
import 'package:grad_project/modules/contact_us/contact_us_screen.dart';
import 'package:grad_project/modules/home_customer/data/model/profile_details.dart';
import 'package:grad_project/modules/profile/screen/profile_screen.dart';

import '../service_locator/service_locator.dart';
import '../utils/colors_palette.dart';
import '../utils/icon_broken.dart';
import 'custom_drawer_list_tile.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({
    super.key,
    required this.name,
    required this.email,
    required this.profileImage,
    this.profile,
  });

  final ProfileDetails? profile;
  final String name;
  final String email;
  final String profileImage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(
              email,
            ),
            accountName: Text(
              name,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage(
                profileImage,
                headers: const {'Cache-Control': 'no-cache'},
              ),
            ),
            decoration: const BoxDecoration(
              color: ColorsPalette.primaryColorApp,
            ),
          ),
          CustomDrawerListTile(
            title: 'Profile',
            icon: IconBroken.Profile,
            onTap: () {
              if (profile != null) {
                context.push(
                  ProfileScreen(profileDetails: profile!),
                );
              }
            },
          ),
          CustomDrawerListTile(
            title: 'Settings',
            icon: IconBroken.Setting,
            onTap: () {
              // context.pus(SettingsOfStudentScreen.routeName);
            },
          ),
          const CustomDrawerListTile(
            title: 'Privacy policy',
            icon: IconBroken.Lock,
          ),
          CustomDrawerListTile(
            title: 'Contact us',
            icon: IconBroken.Calling,
            onTap: () async => await context.push(const ContactUsScreen()),
          ),
          const Spacer(),
          CustomDrawerListTile(
            title: 'Log out',
            icon: IconBroken.Logout,
            onTap: () {
              ServiceLocator.instance<AuthRemoteDataSource>().logout().then(
                (value) {
                  context.pushAndRemoveUntil(
                    const LoginScreen(),
                    (route) => false,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
