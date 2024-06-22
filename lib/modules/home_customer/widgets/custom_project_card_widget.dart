import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grad_project/core/helpers/extensions/navigation_extensions.dart';
import 'package:grad_project/modules/home_customer/screens/project_details_screen.dart';

import '../../../core/utils/colors_palette.dart';
import '../../../core/utils/end_points.dart';
import '../data/project_model.dart';

class CustomProjectCardWidget extends StatelessWidget {
  final ProjectModel project;
  final bool isDetailsAppear;

  const CustomProjectCardWidget({
    super.key,
    required this.project,
     this.isDetailsAppear = true,
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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  project.description ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Created by: ${project.createdById}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Status: ${project.status}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 10),
              if(isDetailsAppear)  Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
