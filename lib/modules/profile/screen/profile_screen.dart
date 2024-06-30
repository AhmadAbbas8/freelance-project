import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grad_project/core/cache_helper/cache_storage.dart';
import 'package:grad_project/core/cache_helper/shared_prefs_keys.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/core/utils/app_strings.dart';
import 'package:grad_project/core/utils/icon_broken.dart';
import 'package:grad_project/modules/auth/data/user_model.dart';
import 'package:grad_project/modules/home_customer/data/model/profile_details.dart';
import 'package:grad_project/modules/home_provider/widgets/custome_job_card_widget.dart';
import 'package:grad_project/modules/profile/widgets/info_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.profileDetails,
  });

  final ProfileDetails profileDetails;

  @override
  Widget build(BuildContext context) {
    var user = UserModel.fromJson(
      json.decode(
        ServiceLocator.instance<CacheStorage>()
            .getData(key: SharedPrefsKeys.user),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CircleAvatar(
              radius: 70,
              child: Image.network(
                AppStrings.defImageMale,
              ),
            ),
          ),
          SliverList.list(
            children: [
              InfoWidget(
                title: profileDetails.name ?? '',
                icon: IconBroken.User,
              ),
              InfoWidget(
                title: profileDetails.phoneNumber ?? '',
                icon: FontAwesomeIcons.phone,
              ),
              InfoWidget(
                title: profileDetails.governorate ?? '',
                icon: FontAwesomeIcons.locationPin,
              ),
              InfoWidget(
                title: profileDetails.birthDate ?? '',
                icon: FontAwesomeIcons.calendar,
              ),
              InfoWidget(
                title: profileDetails.field ?? '',
                icon: IconBroken.Work,
              ),
              InfoWidget(
                title: profileDetails.experienceYears.toString() ?? '',
                icon: Icons.work_history,
              ),
              InfoWidget(
                title: profileDetails.address ?? '',
                icon: FontAwesomeIcons.locationDot,
              ),
            ],
          ),
          if (user.role?.toUpperCase() != 'Provider'.toUpperCase())
            SliverList.builder(
              itemCount: profileDetails.jobs!.length,
              itemBuilder: (context, index) {
                final job = profileDetails.jobs![index];
                return CustomJobsCardWidget(job: job);
              },
            )
        ],
      ),
    );
  }
}
