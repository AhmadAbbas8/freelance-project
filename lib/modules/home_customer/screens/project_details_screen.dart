import 'package:flutter/material.dart';
import 'package:grad_project/modules/home_customer/data/project_model.dart';
import 'package:grad_project/modules/home_customer/widgets/custom_project_card_widget.dart';

import '../widgets/offer_item_widget.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({
    super.key,
    required this.project,
  });

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
      ),
      body: Column(
        children: [
          CustomProjectCardWidget(
            project: project,
            isDetailsAppear: false,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => OffersItemWidget(
                offers: project.offers![index],
              ),
              itemCount: project.offers?.length,
            ),
          )
        ],
      ),
    );
  }
}
