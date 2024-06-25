import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../core/utils/colors_palette.dart';
import '../../../core/utils/end_points.dart';
import '../models/job_model.dart';

class CustomJobsCardWidget extends StatelessWidget {
  const CustomJobsCardWidget({
    super.key,
    required this.job,
    this.onPressedDelete,
  });

  final JobModel job;
  final void Function()? onPressedDelete;

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
            '${EndPoints.BASE_URL}images/${job.imageName}',
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
                  job.title ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  job.description ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Start At: ${job.startsAt}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'End At: ${job.enndsAt}',
                  style: const TextStyle(
                    fontSize: 14,
                    // color: Colors.green,
                  ),
                ),
                const SizedBox(height: 5),

                // if (isDetailsAppear)
                Row(
                  // alignment: Alignment.bottomRight,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: onPressedDelete,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () => log('message'),
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
