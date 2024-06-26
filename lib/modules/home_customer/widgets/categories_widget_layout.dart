import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../core/utils/end_points.dart';
import '../../../core/widgets/loading_widget.dart';
import '../logic/home_customer_cubit.dart';
import 'custom_home_customer_card.dart';

class CategoriesWidgetLayout extends StatelessWidget {
  const CategoriesWidgetLayout({
    super.key,
    required this.cubit,
    required this.state,
  });

  final HomeCustomerCubit cubit;
  final HomeCustomerState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: state is FetchCategoriesLoading || state is FetchCurrentProjectCustomerLoading,
        replacement: Visibility(
          visible: cubit.categories.isEmpty,
          replacement: AnimationLimiter(
            child: ListView.builder(
              itemCount: cubit.categories.length,
              itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 1000),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: CustomHomeCustomerCard(
                      title: cubit.categories[index].title ?? '',
                      providers: cubit.categories[index].providers ?? [],
                      description: cubit.categories[index].description ?? '',
                      imageUrl:
                          '${EndPoints.BASE_URL}/images/${cubit.categories[index].imageName}',
                    ),
                  ),
                ),
              ),
            ),
          ),
          child: const Text('There is No any Category'),
        ),
        child: const LoadingWidget(),
      ),
    );
  }
}


