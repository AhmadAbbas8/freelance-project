import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grad_project/core/utils/app_strings.dart';

import '../data/categories_model.dart';

class ProvidersScreen extends StatelessWidget {
  const ProvidersScreen({
    super.key,
    required this.title,
    required this.providers,
  });

  final String title;
  final List<Providers> providers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Visibility(
        visible: providers.isNotEmpty,
        replacement: Center(
          child: Text('There is No any Providers for $title'),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: AnimationLimiter(
            child: ListView.builder(
              itemBuilder: (context, index) =>
                  AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 1000),
                child: FlipAnimation(
                  child: FadeInAnimation(
                    child: ListTile(
                      title: Text(
                        '${providers[index].firstName} ${providers[index].lastName}',
                      ),
                      subtitle: Text(
                        title,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(AppStrings.defImageMale),
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: providers.length,
            ),
          ),
        ),
      ),
    );
  }
}
