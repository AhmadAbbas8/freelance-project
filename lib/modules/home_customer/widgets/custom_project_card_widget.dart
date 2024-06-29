import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grad_project/core/cache_helper/cache_storage.dart';
import 'package:grad_project/core/cache_helper/shared_prefs_keys.dart';
import 'package:grad_project/core/helpers/extensions/navigation_extensions.dart';
import 'package:grad_project/core/service_locator/service_locator.dart';
import 'package:grad_project/modules/auth/data/user_model.dart';
import 'package:grad_project/modules/home_customer/screens/project_details_screen.dart';

import '../../../core/utils/colors_palette.dart';
import '../../../core/utils/end_points.dart';
import '../data/model/project_model.dart';

class CustomProjectCardWidget extends StatelessWidget {
  final ProjectModel project;
  final bool isDetailsAppear;
  final void Function()? onPressedDone;
  final void Function()? onPressedAssigned;

  const CustomProjectCardWidget({
    super.key,
    required this.project,
    this.isDetailsAppear = true,
    this.onPressedDone,
    this.onPressedAssigned,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 6,
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            '${EndPoints.BASE_URL}/images/${project.imageName}',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  project.description ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Created by: ${project.createdById}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Status: ${project.status}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Offers: ${project.offers?.length} offer',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                if (isDetailsAppear)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: () => context.push(
                            ProjectDetailsScreen(project: project),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ColorsPalette.primaryColorApp.withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text(
                            'Details',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    if(onPressedAssigned!=null)  Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: onPressedAssigned,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[500],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text(
                            'Assigned',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      if(onPressedDone!=null)  Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 8.0),
                        child: ElevatedButton(
                          onPressed:onPressedDone,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text(
                            'Done',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
